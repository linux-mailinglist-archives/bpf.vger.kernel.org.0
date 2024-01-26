Return-Path: <bpf+bounces-20427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D983E2E9
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247721C238BD
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E7225DA;
	Fri, 26 Jan 2024 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPw8JiUn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6322609;
	Fri, 26 Jan 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298571; cv=none; b=X0GKxkPM/KBy3KT8CtxU7Xph23DpsWLTCrpOkhfKYrFsBhfUAdnj2T0hWJXemjveDXQ00JfKkIDO2U3lGJdO0GjGznGAl9armeXFn9mUeF6xjPvwSbfWC4HaYIC6JAfy7xQFBZzCcAwoN9TCriGfPFxff/+DH/CApdL1hUKrq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298571; c=relaxed/simple;
	bh=Wuer9su/jiFsi5sYQQisMPWnekUj/IpB602cKYYl9qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjvJKnll9JrBlJ2u1e+wlWEvM+j7Jw0D6TAtqDamJLKGUoNvRKQBTawIO/0O2V4iTmGGlutNdrwwM3CBbZxkKbc1jrn63Ou/FUvKgwfCj0UIDlwcYIrvjfjP1eXyM8rDp8MSsDzBMS0iaxRjc/s9npul+UEef+iTx2k1E1vaDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPw8JiUn; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so663141276.1;
        Fri, 26 Jan 2024 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706298569; x=1706903369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3iGNpQrB4LeEkd0Y+eOnO8OG2sepjM86FGBNNoLgBw=;
        b=DPw8JiUnEoeYDVvTJFCrqCDhz6P4j9LKKAsDNCcutGe5Kzf5BmE862Yxi3Dh4Qmf0D
         Lj5kxtCUBY7CNupQo3a3zesxEuZEpxeTz6vaBCSyOZlmUXUF0QRLTQaGE4T/VwyL9SxS
         cMyI9vjio/OVe9G60BAffILTmVyvS1O0nLCXnSrNvI8nH6YVztwQC3GMvU632Qs7pNU5
         Mo4G1iuWF/cnQQ4JZUYdq3IF/v3V/RKu6hBAEql9OYmiJpOzFtgCNd0MkC/UB5Fl33CJ
         h62ApoW4TBQ6vwQ4WjWj9fbT+QOj5g/KSXuq6mdvYbW43B9qTdSPKZWmfZRQaYDpM8an
         jzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298569; x=1706903369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3iGNpQrB4LeEkd0Y+eOnO8OG2sepjM86FGBNNoLgBw=;
        b=PR+RTCj1P9d7qxRUcTXwS1OF15etbxzlin4nejvcbnEYxPHz5vRgMWWK91KgpHBgms
         o1acABw1Dd8LD4nU3WkmmSF3sujaZRAFxgn98TRDU3Zy8OW9t66h+U4rMAUZuFJlLQ15
         XE7akyDATmyEpGuWUoT9elh8SWENe4TZseISCzbIxqVHE15vuzcEMhrc7NREINadhvDG
         N5eXf45g1Hh94qbwHTJlVrYEtXpb/aqMETeBbiqa41PeoXiPt6+BEZhP66dgDoAewbyU
         8nB8L1KYHs1s+rq6qmmsNYxG+hixTxGEXW6olL5GgC/qxSYwB539OycjxcNLPC35XZMB
         FqLA==
X-Gm-Message-State: AOJu0Ywz99k6GlaneWqjCygQGBbRLky9wdiTmf0RLJkoQV0H9u+TF5Ac
	Hq76TvuksIbQXBWuAYqTy8Bjd3Ufqvqdc6pyIITUnNoirLNqS+urCxqq9CEpT+EEgS1ECHZbDWh
	FdDFVNO2tyu8shZbEjLtlfAjPXsg=
X-Google-Smtp-Source: AGHT+IHlg4G2/exAQDXNcyzMTeRXf+qek0XjfiGpyFHfZtMMbQj4c6ipRWY3ryT/rlixIdgxmwDjgxcN9EtjG0+KCdw=
X-Received: by 2002:a05:6902:220e:b0:dc2:234d:214d with SMTP id
 dm14-20020a056902220e00b00dc2234d214dmr450594ybb.40.1706298568024; Fri, 26
 Jan 2024 11:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <52a0e08033292a88865aab37b0b3bd294b93e13c.1705432850.git.amery.hung@bytedance.com>
 <1f48019a-fb72-324c-7626-ba5ccb9307b0@iogearbox.net>
In-Reply-To: <1f48019a-fb72-324c-7626-ba5ccb9307b0@iogearbox.net>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 26 Jan 2024 11:49:17 -0800
Message-ID: <CAMB2axPPxq5yF21e-V-JJBoZO4C+EKABCcM2GnEsVZLSecNurw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 7/8] samples/bpf: Add an example of bpf fq qdisc
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:29=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/17/24 10:56 PM, Amery Hung wrote:
> > tc_sch_fq.bpf.c
> > A simple bpf fair queueing (fq) qdisc that gives each flow a euqal chan=
ce
> > to transmit data. The qdisc respects the timestamp in a skb set by an
> > clsact rate limiter. It can also inform the rate limiter about packet d=
rop
> > when enabled to adjust timestamps. The implementation does not prevent =
hash
> > collision of flows nor does it recycle flows.
> >
> > tc_sch_fq.c
> > A user space program to load and attach the eBPF-based fq qdisc, which
> > by default add the bpf fq to the loopback device, but can also add to o=
ther
> > dev and class with '-d' and '-p' options.
> >
> > To test the bpf fq qdisc with the EDT rate limiter:
> > $ tc qdisc add dev lo clsact
> > $ tc filter add dev lo egress bpf obj tc_clsact_edt.bpf.o sec classifie=
r
> > $ ./tc_sch_fq -s
>
> Would be nice if you also include a performance comparison (did you do
> production tests with it?) with side-by-side to native fq and if you see
> a delta elaborate on what would be needed to address it.

I did a simple test by adding a fq to the loopback device and then
sending a single stream traffic via iperf. The bpf implementation of
fq achieves 90% throughput compared with the native one.

I think the overhead mainly comes from allocating bpf objects (struct
skb_node) to store skb kptrs. This part can be removed if bpf
list/rbtree recognizes skb->list/rbnode. On the kfunc implementation
side, I think we can do it by saving struct bpf_rb_node_kern into
skb->rb_node and skb->cb. I haven't looked into the verifier to see
what needs to be done.

I will move the test cases from samples to selftests and include more
testing in the next patchset.

>
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   samples/bpf/Makefile            |   8 +-
> >   samples/bpf/bpf_experimental.h  | 134 +++++++
> >   samples/bpf/tc_clsact_edt.bpf.c | 103 +++++
> >   samples/bpf/tc_sch_fq.bpf.c     | 666 +++++++++++++++++++++++++++++++=
+
> >   samples/bpf/tc_sch_fq.c         | 321 +++++++++++++++
> >   5 files changed, 1231 insertions(+), 1 deletion(-)
> >   create mode 100644 samples/bpf/bpf_experimental.h
> >   create mode 100644 samples/bpf/tc_clsact_edt.bpf.c
> >   create mode 100644 samples/bpf/tc_sch_fq.bpf.c
> >   create mode 100644 samples/bpf/tc_sch_fq.c

