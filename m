Return-Path: <bpf+bounces-8937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ABC78CDDD
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 22:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7821C20A4D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89B182B5;
	Tue, 29 Aug 2023 20:55:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6714AAF
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 20:55:00 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83841BB;
	Tue, 29 Aug 2023 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/NgdtXp/DICobM7HO+s4HjcFUkk7vnW/s3D94cswJsw=; b=A6TlpQmtjSYAOnzjZ558UQlvas
	zI6KxqmVORhEe0w11kn8sI5zNz4H7ay8Kwqcs54jKHKm9jajo3BsRoCsMuf1H/OcYmuMTh6xs2ORN
	n12ZN0bCBnKjdD1ApAOiKPTSuIHDmfcmVB84RT0gLmtUYYrxpw/xyAS1vHicgLd2YQ/iw+cvg/xlD
	Kj2PhCzboqfjWx7QRsqZ8ReJRZBIuYcaEBJJWr+C1STOzI6V6ArIyyRSJOW8oJO5IG4rJg2Yc2L2g
	dr+Xw7vquFBcoYp+1ViDYR0Y4Q+7HESJRZxlKjz9vrIk1tloDFlpO3P+IfeDMuL00/eBMmLrVdWS6
	VXjgDPLQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qb5jk-000ISl-Gf; Tue, 29 Aug 2023 22:54:56 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qb5jk-0002vb-8A; Tue, 29 Aug 2023 22:54:56 +0200
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
To: Marco Elver <elver@google.com>
Cc: yonghong.song@linux.dev,
 syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <000000000000d87a7f06040c970c@google.com>
 <2e260b7c-2a89-2d0c-afb5-708c34230db2@linux.dev>
 <CANpmjNOG4f-NnGX6rpA-X8JtRtTkUH8PiLvMj_WJsp+sbq6PNg@mail.gmail.com>
 <f09d1d92-3e32-46a6-d20d-41bf74268d0c@iogearbox.net>
 <CANpmjNMiNw8Cwe0Rk2jWD7Ju-e-jAXgdnuwvvsPR1QYq=4HcwQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4980327b-698d-5c1a-42ab-327dc6a47515@iogearbox.net>
Date: Tue, 29 Aug 2023 22:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANpmjNMiNw8Cwe0Rk2jWD7Ju-e-jAXgdnuwvvsPR1QYq=4HcwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27015/Tue Aug 29 09:39:45 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 10:36 PM, Marco Elver wrote:
[...]
> In this case, maybe data_race(*ldst++ = *lsrc++) would be more
> appropriate and efficient. Unlikely that READ_ONCE()/WRITE_ONCE() here
> helps make this any safer, i.e. the memcpy is still not atomic and if
> it's a bug on the user's side, it'll corrupt data either way.

I wasn't aware of data_race(), thanks for the suggestion! Just flushed out
a small patch.

Thanks,
Daniel

