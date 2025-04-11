Return-Path: <bpf+bounces-55762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE02A8648B
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8477AB096
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058622D7B2;
	Fri, 11 Apr 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3n9tAdL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9122CBE6;
	Fri, 11 Apr 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392039; cv=none; b=nasYy+KM+o6fa3drFeysOCSjDLdlRbiZGSGvUVIZF+Hs8uXcZpvdFEeDp25ZrMRj82mxQX3OWz36LgvXFwz1Nu4apyMzyvyXhIqnQMkEvEdsk6hoLv3K1vB7PcekboDpd8Z52GS3EvuPqC87fHgQk1nPoI5KeeAJ4oM7y55+1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392039; c=relaxed/simple;
	bh=kC41ggqOl42T1XExsmIha6HDEC6a2U6zk30XNUp2tO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJ07JETFt9upmgBlE1VnxUOUAbk8qMjjgdtg0FBn8BtbGsINo3fmlOjo66QuKapTYuQPE0Tv6ZMEL+Pj7hb+tdZRsXN4jJQDxMMYORebQ4hss4I8GZA3GTEmfmSAa7hpRfjPggckumHaG6MBJu8+aUsS+tAkCgX37VhoElol+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3n9tAdL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff37565154so21734307b3.3;
        Fri, 11 Apr 2025 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744392036; x=1744996836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ow0ImkZmU1VcIMoUQJPg9f07axpEsSYmctK4U8rsSY=;
        b=P3n9tAdLenney6vdUVJOEYj4dbavmkEGCH/qdDiBv70SZkMaDsUiEZbcgdOZgPMWnc
         brOiJOg2bS9rHBcdkuEr/CxFAN9ulyR4czLUyVulgIKSu5Y5aFYkwAQ/vWdkiKXVfVnZ
         jWZOgCFZnbzGIncqoA/XiAZsJ7Cxb2+lhRZFe8evE6Kp0nwW27TZj+XOl/PNBPaWpIBy
         feskjjyZ3Kfdf/aihxfZ5kE2F5j5dw9xW0D3zjWoi5OaVQf58pT5M5fDelStYO22qDVR
         PNQd/XVzxE5YGRIDn+NTBGCE2IHiUhlw8Z5Io0GtDh9Uuv6J+h0TjyB1zucjZuQJ4x3x
         8LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392036; x=1744996836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ow0ImkZmU1VcIMoUQJPg9f07axpEsSYmctK4U8rsSY=;
        b=T80MmacpBpX0DCwyTZYvFRp4IEFwACJpdBJdQFgwvp5UCtRHesuN3oR11kfifcxhAI
         h08E0OpbNLuNDekgthVFil8/q5VcUR/hBZAQ44tYCUHfR96E+aMe/8ebHcw496Kvh+IK
         0LCUJuxvQpldmbjEG18BUQ7pSnR7u0Mno0CFNDTepmaD34GVdcnF9IGCNJYhbezbHuCp
         6jYJJUSsxoKlIRYUAmaAhgORgVX9s5XCwxdxeFzrDt6IMfX4D9v6srQpYc+EYV2+4cEG
         o5fkvzolseIemTo4o8p8sL6M85YgqjMc47+d0zhf95pRbRSkhTGpIJLYeI9g5oR1ZjJF
         VrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV530gb7ne6Pm0rBvHCgr7Prb1rKh3McbgUE3iW39VSHshTqXEN2EakXoUI9k51RK9kwRJ2T6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92+Vwzwr1ZNxHnJHB8ADFQc1AdBF+mvoSbdoqeH4azqtw7Vji
	XcvDaVBqSFFkYssmDwQZbqsGP0P6q7VI3r0LHvIM0fFY+cbi4GIs6xNJfP5V02QH1wx/vZHtUix
	I+xdmjsLKjJ0sljRP2R75U3qHyM0=
X-Gm-Gg: ASbGncs693sy5U4ZLbaKiTW9RNN3QnbDCwTqDStaYJR8G0fjKtFyHTRlnyfxIA8FU+X
	wCnN8LA+EL1eiomLnTwiIyjunfWRGGdvt73Ni5CRUnxO87lNRTYwsqrSL/588+/SNiJPjutb8eM
	ZnxkpTBpbD6f4NNCGpaza0tg==
X-Google-Smtp-Source: AGHT+IHiD73G9OPhaNUYkUixJ7VV8u+vQQrenSkFHqe98daVV04S+gRhDc66SR2WTO0ANRmFYxy1Id9O+jIjgT8FL+8=
X-Received: by 2002:a05:690c:6103:b0:6fe:b7ed:9715 with SMTP id
 00721157ae682-705599d310emr73074017b3.11.1744392036507; Fri, 11 Apr 2025
 10:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-9-ameryhung@gmail.com>
 <CABx7vpW8mCNpoCCDwJyWAXM1atSxfbc6O-su3g6BQA-GmzOm4w@mail.gmail.com>
In-Reply-To: <CABx7vpW8mCNpoCCDwJyWAXM1atSxfbc6O-su3g6BQA-GmzOm4w@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Apr 2025 10:20:25 -0700
X-Gm-Features: ATxdqUFABjnsVUfBllCia5gh6DnePUswv90BChImHTkgmTcCGvwaIunO09vijLU
Message-ID: <CAMB2axN2DPfTOAaf=7byckUXjkJOVUmN3faM_HTQ5hTifAWo1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 08/10] selftests/bpf: Add a basic fifo qdisc test
To: Martin KaFai Lau <iamkafai@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:59=E2=80=AFPM Martin KaFai Lau <iamkafai@gmail.co=
m> wrote:
>
> On Wed, Apr 9, 2025 at 2:49=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> > +void test_bpf_qdisc(void)
>
> nit. re-name to "test_ns_bpf_qdisc"....
>
> > +{
> > +       struct netns_obj *netns;
> > +
> > +       netns =3D netns_new("bpf_qdisc_ns", true);
>
> ... then this can be saved.
>
> > +       if (!ASSERT_OK_PTR(netns, "netns_new"))
> > +               return;
> > +
> > +       if (test__start_subtest("fifo"))
> > +               test_fifo();
> > +
> > +       netns_free(netns);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/too=
ls/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > new file mode 100644
> > index 000000000000..65a2c561c0bb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _BPF_QDISC_COMMON_H
> > +#define _BPF_QDISC_COMMON_H
> > +
> > +#define NET_XMIT_SUCCESS        0x00
> > +#define NET_XMIT_DROP           0x01    /* skb dropped                =
  */
> > +#define NET_XMIT_CN             0x02    /* congestion notification    =
  */
> > +
> > +#define TC_PRIO_CONTROL  7
> > +#define TC_PRIO_MAX      15
> > +
> > +#define private(name) SEC(".data." #name) __hidden __attribute__((alig=
ned(8)))
> > +
> > +u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
> > +void bpf_kfree_skb(struct sk_buff *p) __ksym;
> > +void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_=
free) __ksym;
> > +void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 de=
lta_ns) __ksym;
> > +void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *=
skb) __ksym;
>
> nit. These kfunc declarations should be no longer needed. vmlinux.h
> should already have them. Update pahole if vmlinux.h does not have
> them.
>
> The set has been applied. Please consider following up the nits in
> selftests. Thanks.

I will send a follow up addressing two things you mentioned. Thanks
for the suggestions.

