Return-Path: <bpf+bounces-5875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C9076240F
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641F21C20FC4
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AD26B73;
	Tue, 25 Jul 2023 21:00:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2E23BF5;
	Tue, 25 Jul 2023 21:00:54 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791EBE78;
	Tue, 25 Jul 2023 14:00:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b935316214so3626601fa.1;
        Tue, 25 Jul 2023 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690318852; x=1690923652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP0Ad9ZYbf8ZzfPr//Y47DXa0wIU8SOl3KLyUj0/PiE=;
        b=rUp5Rh+uwSc3mLFndhwjsnLwHgrvkBQtkxYMzQ0TkRLvWc8mlgz2Wqbxrbuga05JKF
         yWAAJSCECJTDF7q0xUEz2Be125ZSMxlC2oxdhoOx9iPKFawo71D6kLctw/nclirPa8ds
         MaaZbKu2cV4v2Q9t/oEKC/F4i7PiUTUiD7n3vFXhuZ7MBrLUFiwuXQ7PRkcPXpD7xHVg
         6SCFXKjQaZyCpp0PI08xpwwaoCSDk1h4l2ihdInOFzm9Y24qj/WNzXSwH7+K11NHl3b5
         ymxd5s3p0pp+pGaZbGB2Si8k1zp7XAFeUlT6ZzJAGCVdx/wl9AIB77TgUwN+y9zC1iwJ
         UCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318852; x=1690923652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP0Ad9ZYbf8ZzfPr//Y47DXa0wIU8SOl3KLyUj0/PiE=;
        b=AN0vuxBUawEP/fRko2SOsvaFdMsZqst49Bho0ZUaYBQu1H9+s0wDrCCj7uzcO7S3rN
         or7PKMyaqRkU/KoPTYfq0NPWpfFyOiMEZISawjnRi57EDOnC8B+XSK4ivBzHOHl0qr81
         7Z6h7qRSXPpmyJyoSl7bBh8yeTuHKg+wRX9hlXnRPpwbjxuxqIK+P/PCq9WXUVcN6xlH
         1IqHEOr2Ne7ieNb88+L226oKIAMYfMXJ7HleapXSyNGUzD2A6Sh1ftOQJWaWkM43wqJr
         /7ADgORRHK5joFAzSYDgOlV4sPCmTID+vlaYW53bostsJJO7xRgS5q9S21CiXMsB1Ymm
         Br2g==
X-Gm-Message-State: ABy/qLa18fgS+e3KXk/TGIm9kfpEnZWyIY/qFA5eZA/RfmlU5ZTJfaC2
	Wa7GhbovNRA51joEWGiE3XbVU7X0opapHWx4Lrs=
X-Google-Smtp-Source: APBJJlF/U8yZemAC/wjNOB7cBzY+1jHtL9d3+AzXwkQIBJUz2CZVt6HrunFdp/6br8Q4/Q4HT7+wzwx3U51a7+LFvyU=
X-Received: by 2002:a05:651c:48c:b0:2b7:34c4:f98f with SMTP id
 s12-20020a05651c048c00b002b734c4f98fmr1268577ljc.11.1690318851402; Tue, 25
 Jul 2023 14:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230317201920.62030-1-alexei.starovoitov@gmail.com> <ZMA0SFhEDRp0UFGc@google.com>
In-Reply-To: <ZMA0SFhEDRp0UFGc@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jul 2023 14:00:40 -0700
Message-ID: <CAADnVQLkB4dkdje5hq9ZLW0fgiDhEWU0DW67zRtJzLOKTRGhbQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] bpf: Add detection of kfuncs.
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 1:45=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Hey Alexei/Andrii,
>
> On Fri, Mar 17, 2023 at 01:19:16PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Allow BPF programs detect at load time whether particular kfunc exists.
>
> So, I'm running a GCC built 6.3.7 Linux kernel and I'm attempting to
> detect whether a specific kfunc i.e. bpf_rcu_read_lock/unlock() exists
> using the bpf_ksym_exists() macro. However, I'm running into several
> BPF verifier constraints that I'm not entirely sure how to work around
> on the aforementioned Linux kernel version, and hence why I'm reaching
> out for some guidance.
>
> The first BPF verifier constraint that I'm running into is that prior
> to commit 58aa2afbb1e6 ("bpf: Allow ld_imm64 instruction to point to
> kfunc"), it seems that the ld_imm64 instruction with BPF_PSEUDO_BTF_ID
> can only hold a ksym address for the kind KIND_VAR. However, when
> attempting to use the kfuncs bpf_rcu_read_lock/unlock() from a BPF
> program, the kind associated with the BPF_PSEUDO_BTF_ID is actually
> KIND_FUNC, and therefore trips over this BPF verifier.
>
> The code within the example BPF program is along the lines of the
> following:
> ```
> ...
> void bpf_rcu_read_lock(void) __ksym __weak;
> void bpf_rcu_read_unlock(void) __ksym __weak;
> ...
> if (bpf_ksym_exists(bpf_rcu_read_lock)) {
>    bpf_rcu_read_lock();
> }
> ...
> if (bpf_ksym_exists(bpf_rcu_read_unlock)) {
>    bpf_rcu_read_unlock();
> }
> ...
> ```
>
> The BPF verifier error message that is generated on a 6.3.7 Linux
> kernel when attempting to load a BPF program that makes use of the
> above approach is as follows:
>    * "pseudo btf_id {BTF_ID} in ldimm64 isn't KIND_VAR"
>
> The second BPF verifier constraint comes from attempting to work
> around the first BPF verifier constraint that I've mentioned
> above. This is trivially by dropping the conditionals that contain the
> bpf_ksym_exists() check and unconditionally calling the kfuncs
> bpf_rcu_read_lock/unlock().
>
> The code within the example BPF program is along the lines of the
> following:
> ```
> ...
> void bpf_rcu_read_lock(void) __ksym __weak;
> void bpf_rcu_read_unlock(void) __ksym __weak;
> ...
> bpf_rcu_read_lock();
> ...
> bpf_rcu_read_unlock();
> ...
> ```
>
> However, in this case the BPF verifier error message that is generated
> on a 6.3.7 Linux kernel is as follows:
>    * "no vmlinux btf rcu tag support for kfunc bpf_rcu_read_lock"
>
> This approach would be suboptimal anyway as the BPF program would fail
> to load on older Linux kernels complaining that the kfunc is
> referenced but couldn't be resolved.
>
> Having said this, what's the best way to resolve this on a 6.3.7 Linux
> kernel? The first BPF program I mentioned above making use of the
> bpf_ksym_exists() macro works on a 6.4 Linux kernel with commit
> 58aa2afbb1e6 ("bpf: Allow ld_imm64 instruction to point to kfunc")
> applied. Also, the first BPF program I mentioned above works on a
> 6.1.* Linux kernel...

Backport of that commit to 6.3.x is probably the only way.

And I don't think bpf_ksym_exists() actually works on 6.1

