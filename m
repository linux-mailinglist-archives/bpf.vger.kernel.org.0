Return-Path: <bpf+bounces-20123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FFC839AEA
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB92B2637C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4502C1BF;
	Tue, 23 Jan 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quO6j1Ul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704C2940A
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044416; cv=none; b=rgw6mmz2v8OJtWRg8wofzV4Q5TLWRhjuxqvhHDgQgr1cZNsXqRbWjonxm7k4D7FhvojXefPGGi259jrH6gZXohxiG71MM1T9sNzMGpkQKhzR1aR1bzSzyLqa+ExlGPgwOIjATWNpARDIQvM0eCWX8gWzlKqf1oxDcY3x7Gdb7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044416; c=relaxed/simple;
	bh=KvG7s9NFxXh/ASeoRV7N++bRQmKHC0GzhUztn43ijkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oFRfnHO/5oiGnMLrsoa6U3RxI8XqlkdRyGg4FUVHWJ317cSpsRI0DACif0RiXPEy/FK64F93CJRtPenWUjcHXE3Wei8Z5qC1djSD5qCCw7w/gSVekAHtMIthGAonKz5H7FAEYVZ6gRT3PiP3P95MhmMnpjpjnjAfHgCqduK9pNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quO6j1Ul; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so2325407a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706044415; x=1706649215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6at6keMSgruOD1RN1HfvOSJSeWb8gkKlL4SoQsrDAUQ=;
        b=quO6j1Ul/N6rPjZwK2V+upJaZhuZkLKl6/7PMWlNmEv7ftrXSH4/4Xvc4+XsA86EKH
         FGrjG6I64EExWzswMwwl+lm+vHSNn5RkNxFrR5m8CPx3lKheDYW1QTVKNp+LvSnaRXF/
         5gotVfes1JYSgi9SxuarTsMz+MMeEe2QIRjeTYYOqTFcYJh9cetUU73fb+4ItZnUefGq
         tYhyar9a+kMO2rAzLozvExDdbHNWks3z0dWaHlIQajeelsL6x8NgmAwsL4ZhsVLKqMQq
         IizyEcF0W6055uok7WOClQu7WZ26wDqLqrcPD9nnoZdB5G9fSoN6vTfAaVU2Tqk6iAat
         mi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706044415; x=1706649215;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6at6keMSgruOD1RN1HfvOSJSeWb8gkKlL4SoQsrDAUQ=;
        b=uAaI409miY8i+3ZHGZ9xm0hqBsAg6vHAtIMMYw+p/ZY3z3PYh0B55YlEh2jyO3b5jR
         +G9N3f16O4ls7zYH/DMRhThhYYs7+vLd749CM6ZzzR0PvB+RzPHS/Co+Gm9U3aAYOzPw
         JlLG4KcULKPejBLazMI06S8ZJmxjwoG31gzE593j0ni87xryQRnm5CmizVC+uqf9KmdI
         yJYy9mxi0Bsg7PDDxn6JpX9zOpTs5GB0Z4+Q0qD+jkIu73aIJOu83zpgWhx/Or6QnqqB
         JhxwBEZ0iiGCoB/m+jCpOtpYPpxAqi6jH/42qX+oq9Th18Dez+U3ggms1GbX3KePUMgv
         RmDg==
X-Gm-Message-State: AOJu0YzPfWVLzC7Ui5msjrfq/Em9+Z25aBaP4MqDe2lDnCZU1Y23dvLa
	4u3A2xDZp67YiX9lSQkl+ofXDQq9xtyca1UEf0woi6VmSh5fUsgGZwZQFTrFnrG1VA==
X-Google-Smtp-Source: AGHT+IELKKyZtobF0wBhEBMho6pJdPd3y/Lc1wRbAgWW9P/JfKPN+3Cty36Otq0B3XZmoxdNY55lwfU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a02:90d:b0:5d4:c1c9:4964 with SMTP id
 ck13-20020a056a02090d00b005d4c1c94964mr454pgb.10.1706044414816; Tue, 23 Jan
 2024 13:13:34 -0800 (PST)
Date: Tue, 23 Jan 2024 13:13:33 -0800
In-Reply-To: <cover.1705432850.git.amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
Message-ID: <ZbAr_dWoRnjbvv04@google.com>
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
From: Stanislav Fomichev <sdf@google.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/17, Amery Hung wrote:
> Hi,=20
>=20
> I am continuing the work of ebpf-based Qdisc based on Cong=E2=80=99s prev=
ious
> RFC. The followings are some use cases of eBPF Qdisc:
>=20
> 1. Allow customizing Qdiscs in an easier way. So that people don't
>    have to write a complete Qdisc kernel module just to experiment
>    some new queuing theory.
>=20
> 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
>    is before enqueue, it is impossible to adjust those "tokens" after
>    packets get dropped in enqueue. With eBPF Qdisc, it is easy to
>    be solved with a shared map between clsact and sch_bpf.
>=20
> 3. Replace qevents, as now the user gains much more control over the
>    skb and queues.
>=20
> 4. Provide a new way to reuse TC filters. Currently TC relies on filter
>    chain and block to reuse the TC filters, but they are too complicated
>    to understand. With eBPF helper bpf_skb_tc_classify(), we can invoke
>    TC filters on _any_ Qdisc (even on a different netdev) to do the
>    classification.
>=20
> 5. Potentially pave a way for ingress to queue packets, although
>    current implementation is still only for egress.
>=20
> I=E2=80=99ve combed through previous comments and appreciated the feedbac=
ks.
> Some major changes in this RFC is the use of kptr to skb to maintain
> the validility of skb during its lifetime in the Qdisc, dropping rbtree
> maps, and the inclusion of two examples.=20
>=20
> Some questions for discussion:
>=20
> 1. We now pass a trusted kptr of sk_buff to the program instead of
>    __sk_buff. This makes most helpers using __sk_buff incompatible
>    with eBPF qdisc. An alternative is to still use __sk_buff in the
>    context and use bpf_cast_to_kern_ctx() to acquire the kptr. However,
>    this can only be applied to enqueue program, since in dequeue program
>    skbs do not come from ctx but kptrs exchanged out of maps (i.e., there
>    is no __sk_buff). Any suggestion for making skb kptr and helper
>    functions compatible?
>=20
> 2. The current patchset uses netlink. Do we also want to use bpf_link
>    for attachment?

[..]

> 3. People have suggested struct_ops. We chose not to use struct_ops since
>    users might want to create multiple bpf qdiscs with different
>    implementations. Current struct_ops attachment model does not seem
>    to support replacing only functions of a specific instance of a module=
,
>    but I might be wrong.

I still feel like it deserves at leasta try. Maybe we can find some potenti=
al
path where struct_ops can allow different implementations (Martin probably
has some ideas about that). I looked at the bpf qdisc itself and it doesn't
really have anything complicated (besides trying to play nicely with other
tc classes/actions, but I'm not sure how relevant that is).

With struct_ops you can also get your (2) addressed.

