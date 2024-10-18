Return-Path: <bpf+bounces-42359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B99A327E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 04:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC51F24175
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6B78C60;
	Fri, 18 Oct 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQLV9Xxv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAB481A3
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217851; cv=none; b=p9cSc2v3LdHCXKId+eQTiA3HvI2lJzABR3yLvfrzalH/63DbYM5Pwrpoe0dlfcyc0EmrU4gvQ07qINcK9R1vACq5FPgkb9QpN/oCZAZw4K9Czp8xRdPhsBi9n8otOiTymqY0Yc7bfl2WbYV0htIlMjaHZ9OK0XPcwfZ2T9DrMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217851; c=relaxed/simple;
	bh=cXmFuU3hl80AWpI9Sbnzob5ySx9oCG3xby6WuWbqamg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ttp2fyBhnPUgxOl9sLoaYeMRldoohuCZTNCKcR8DkQmMuwiB8RECvjntmu/5kMEdEpZPt7FYFpdQYzFtZI70vWlNqUq4IFRiTunA2Gk1HHcGXztvcmN1smeI7svOCQCs0ntroZ5ap8t+EAJqpt4v21LZlj31Z/7o057iZzZfSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQLV9Xxv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso927351b3a.3
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 19:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729217849; x=1729822649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sY1tk31eY5PmrWYW+0qrwmPB9QN1df6dKOqnGK0mPto=;
        b=LQLV9XxvfcEvPCPshfBtpp8jq8J7yAW6cKtS0JG8FVw1Rz8CfBeosrSMl6I2aRflIm
         AWrUpKiS1NncYR9sK3XFOxIYuzCQgVGHGxPnsmKPg/L/02VXBkez0jmP6kxq5fS3nTXa
         tKSTZhiDWU1+IU4ZxEdgAYBynwrGtCjQtfGh+fPmaxnJFiYjwMIMgcDc8Zo100X2HMw7
         b7JeiJf+5yYQD7taaIwtP+xmeHJlVIpH4CX9EKU+cq3MY41CkYqtbflOQnMQwUyE6Ttz
         qdoMIXSToGbJcOJNLiwlYS+WciMUVXPr1885F3T9XoRKzEqVVNhl3FSdnPaRFNzNTi5o
         3WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729217849; x=1729822649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sY1tk31eY5PmrWYW+0qrwmPB9QN1df6dKOqnGK0mPto=;
        b=ddePyfS9zi9F/mYhQACZvn/OXGINfKBYwoYX9bPnD6RMab6t1HUR1OyIxG53dN/xWT
         9hh55hoG66JCkPuU31qcbBqjEACRGWpfXHncA3NQ8GTrasiQvzBkiZlUIlma5pquNtOS
         XiszvMo1SQmQnKSpBgHOjLHxnHVytm/Hfo+PIt954HsSvr+WSFnrJ0ewZ2KDqNDjv9x8
         0GEN1/qnPM6E6rclJO+JdO1yU3PeOt0cNpcGt7Y8zZzwsiuM6RUcA2uzXlQqKjyYZdvb
         KpxbAPPAGPiedUMQHun3LYKeq82LJtS2RpleQwxRw8pBhDuQfnAIzLF9YculdzLqKZHd
         BR+w==
X-Forwarded-Encrypted: i=1; AJvYcCUjTz1Sh/x4VKlAwn68U9wlVDcGIvylk+Nz5WG/Kl3ml2wnLZIhTMarDmg9iTZleqdrfqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bjZTo7kxwLZlkfgxiw9+VkJbi26FyOnw9F8WifA5EdsmSI01
	sxG3v8GYxLpPyfHpt+g69w7af+hh2DRpJoHcxDrFats/rtDUwNwl
X-Google-Smtp-Source: AGHT+IGyym2pWaBrdXlf4WBwIysWVQ/TNG7KgzqrBSM4igPy/2DBqQS3YMzlvJy3jnq7gXRbZmqO3g==
X-Received: by 2002:a05:6a00:3929:b0:71d:fbf3:f769 with SMTP id d2e1a72fcca58-71ea322d35bmr1755259b3a.28.1729217849395;
        Thu, 17 Oct 2024 19:17:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34ab98fsm352323b3a.193.2024.10.17.19.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:17:28 -0700 (PDT)
Message-ID: <1019fe0ba9fecc7025754de1cb732befdf237bd0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop
 back-edges
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Thu, 17 Oct 2024 19:17:24 -0700
In-Reply-To: <CAADnVQ+Hmfp3jojCYMSi_ZacJpPov4+nPwJ7j+UR=cBN3xHxCA@mail.gmail.com>
References: <20241009021254.2805446-1-eddyz87@gmail.com>
	 <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
	 <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
	 <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com>
	 <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com>
	 <be3d3c31438727096c9bc79f6761865574477a71.camel@gmail.com>
	 <CAADnVQ+Hmfp3jojCYMSi_ZacJpPov4+nPwJ7j+UR=cBN3xHxCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 16:23 -0700, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 3:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2024-10-10 at 15:40 -0700, Eduard Zingerman wrote:
> >=20
> > > I think this would bring significant speedup.
> > > Not sure it would completely fix the issue at hand,
> > > as mark_chain_precision() walks like 100 instructions back on each
> > > iteration of the loop, but it might be a step in the right direction.
> >=20
> > In theory, we can do mark_chain_precision() lazily:
> > - mark that certain registers need precision for an instruction;
> > - wait till next checkpoint is created;
> > - do the walk for marked registers.
> >=20
> > This should be simpler to implement on top of what Andrii suggests.
>=20
> Indeed it can wait until the next new_state, since
> when the next iteration of the loop starts the sl->state
> are guaranteed to be some olderstates. Though the verifier may have done
> multiple loop iteration traversals, but it's still in 'cur' state,
> so states_equal(env, &sl->state, cur...) should still be correct.

After spending absolutely unreasonable amount of time on this I
finally identified the missing piece of the puzzle.

The example program takes so much time to verify because it
accumulates a huge jmp_history array (262145 entries)
within a single state and constantly executes mark_chain_precision()
against it.

The reason for such huge jmp_history is an interplay between two
conditions:

	if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
	    env->insn_processed - env->prev_insn_processed >=3D 8)
		add_new_state =3D true;

and

	if (!force_new_state &&
	    env->jmps_processed - env->prev_jmps_processed < 20 &&
	    env->insn_processed - env->prev_insn_processed < 100)
		add_new_state =3D false;

I try to explain it in the commit message for [1].

If one waits long enough, the verifier eventually finishes with
-ENOMEM, as it fails to allocate big enough jmp_history array
(one has to wait 15 minutes on master, and about a minute with my patch [2]=
,
 the patch has not changed since our discussion on Wednesday,
 the error message is the same as we discussed on Wednesday).

The discussed change to lazy precision marks propagation turned out to
be a dud:
- it does not solve the issue at hand, verifier still exits with
  ENOMEM, just faster;
- overall verification speedup for regular programs is not big:

$ ./veristat -e file,prog,duration -f 'duration>100000' -C master-baseline.=
log current.log=20
File                      Program           Duration (us) (A)  Duration (us=
) (B)  Duration (us) (DIFF)
------------------------  ----------------  -----------------  ------------=
-----  --------------------
loop1.bpf.o               nested_loops                 124334             1=
17382        -6952 (-5.59%)
loop3.bpf.o               while_true                   318165             2=
53264      -64901 (-20.40%)
pyperf100.bpf.o           on_event                     704852             6=
92300       -12552 (-1.78%)
pyperf180.bpf.o           on_event                    2304115            22=
51502       -52613 (-2.28%)
pyperf50.bpf.o            on_event                     183971             1=
84124         +153 (+0.08%)
pyperf600.bpf.o           on_event                    2076073            20=
51733       -24340 (-1.17%)
pyperf600_nounroll.bpf.o  on_event                     394093             4=
02552        +8459 (+2.15%)
strobemeta.bpf.o          on_event                     169218             1=
69835         +617 (+0.36%)
test_verif_scale1.bpf.o   balancer_ingress             144779             1=
46486        +1707 (+1.18%)
test_verif_scale2.bpf.o   balancer_ingress             147078             1=
51902        +4824 (+3.28%)
test_verif_scale3.bpf.o   balancer_ingress             184959             1=
88723        +3764 (+2.04%)

Here only loop3 demonstrates significant speedup (re-run for loop3 several =
times),
but it does not warrant the code change in my opinion.

[1] https://lore.kernel.org/bpf/20241018020307.1766906-1-eddyz87@gmail.com/
[2] https://github.com/eddyz87/bpf/tree/lazy-mark-chain-precision


