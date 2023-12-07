Return-Path: <bpf+bounces-16995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09995808488
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 10:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDB6283A57
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5304533CD8;
	Thu,  7 Dec 2023 09:26:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0DD6D
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 01:26:35 -0800 (PST)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3B79PpUX093932;
	Thu, 7 Dec 2023 18:25:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 07 Dec 2023 18:25:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3B79PpuO093926
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 7 Dec 2023 18:25:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1d8193cc-c87e-41b0-83d3-cba4306291bc@I-love.SAKURA.ne.jp>
Date: Thu, 7 Dec 2023 18:25:50 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF LSM prevent program unload
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>,
        Frederick Lawler
 <fred@cloudflare.com>,
        Paul Moore <paul@paul-moore.com>, jmorris@namei.org,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org, kernel-team@cloudflare.com,
        linux-security-module@vger.kernel.org
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
 <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>
 <ZXCNC8nJZryEy+VR@CMGLRV3>
 <CALOAHbAfixyvA5HpOXgqS32G-5p4Z=OXRso7_isz2fNKk76mmg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CALOAHbAfixyvA5HpOXgqS32G-5p4Z=OXRso7_isz2fNKk76mmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/07 11:28, Yafang Shao wrote:
>>>> Moving individual pins or moving the mount entirely with mount --move
>>>> do not perform any clean up operations. Lastly, bpftool doesn't currently
>>>> have the ability to unload LSM's AFAIK.
>>>>
>>>> The few ideas I have floating around are:
>>>>
>>>> 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the functions
>>>>    security_sb_umount(), security_path_unlink(), security_inode_unlink().
>>>>
>>>>    Both security_path_unlink() and security_inode_unlink() handle the
>>>>    unlink/remove case, but not the umount case.

That is what I thought at
https://lkml.kernel.org/r/c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp ,
though I didn't try it because the conclusion was that trying to re-implement TOMOYO
LSM module using BPF is not realistic.

While hooking security_sb_umount() from LSM modules will be possible,
unconditionally rejecting umount operation might confuse userspace programs
(e.g. retry until umount operation succeeds). Therefore, maybe introducing a
kernel thread who holds a refcount using a file descriptor ownded by that
kernel thread is better than trying to manage individual mount namepsaces
and inodes... Letting a kernel code to intentionally leak that refcount
instead of storing into somewhere might be possible, but that is considered
as a kernel bug.


