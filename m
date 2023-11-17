Return-Path: <bpf+bounces-15228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B37EF25C
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 13:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E15228132E
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19930652;
	Fri, 17 Nov 2023 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kd90w1wz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF21A5
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 04:09:57 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59b5484fbe6so20982827b3.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 04:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700222996; x=1700827796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYQlGIwLeSviWE41n6VWqdIoxFsrf3i0EWZOBWnwmko=;
        b=kd90w1wzF3n5lPKDtcPiD/4PoVom5zLZ9zAiTlJcosuS26Ja29+Gshc02EAgoMmPXD
         RmxggolCo3UBVlqxJJeviUPQmEkjN4nohyvtVIxQP0O26/w8sN+WX/ABK15vMUVx553C
         +DTuVWzZHrjNPivT0FrCiouCJEMov6ijRSNb5ja0jniX08uBHfK2LdmM/PbSdGVfuguy
         /Bh7I/dpcOIjfRaiRzmM39W11QEs89yu+dLaRD5guzEWAA7t58RQkzVYaoJC7cXiqE6O
         JfvP5lLdMmv3f2Nrrzk4xJutCNXnXv4aiMbfGtcWvR+tfZ3f719S04AE5qQJXw2QMYM5
         ppyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700222996; x=1700827796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYQlGIwLeSviWE41n6VWqdIoxFsrf3i0EWZOBWnwmko=;
        b=CETioQJrz44xMgsdNYxPiJOb+GdTxDcYyrnjMsvW8eOefP23SZitu2jzlor4kwEqx7
         IU7WAFztOT8w11bT1oLDeeJrihBlTxFtZgR4Ab6FZLhJVmate06ITY02JMMyrSiauN0c
         IvQ+jQzE5RblkSiUBne9mbUXLS7sTfc9gV0/izevfr1NHbX0nme5Xh3aZncC6HNM3hCZ
         GI4wLD5fVq4Stm1ZW92MdryvpLMziQkuaICu2CoeJSHNCYD4p7ZzBN8M/eskDAcq+C5b
         x+jEcjTSyC4d75ViZZzZr3i2r+h8EW9Y11HHY0znvO2enuP+n3exwR8wyMzSOWR4Oqcv
         rlyA==
X-Gm-Message-State: AOJu0YylGNj+y4GjHOHsrpgoCm06vB+gMrZYIBJNM6CXn2gfAz8U8GMi
	y4wnjnkiBBNwMJ4NfJ78yKpYq6yEVvwhpsBTIalplg==
X-Google-Smtp-Source: AGHT+IFBSNvM7dgUd/VdbDeo/DtKOhfgqxdklyqdWVNaTrqTLHw6kXh/1bT4xrZGkQetP776txwNhRLAxe601wCbtSk=
X-Received: by 2002:a0d:fb82:0:b0:5a7:be29:19ac with SMTP id
 l124-20020a0dfb82000000b005a7be2919acmr19330917ywf.12.1700222996186; Fri, 17
 Nov 2023 04:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho>
In-Reply-To: <ZVY/GBIC4ckerGSc@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 17 Nov 2023 07:09:45 -0500
Message-ID: <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, 
	David Ahern <dsahern@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:11=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:
>
> [...]
>
>
> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
> >index ba32dba66..4d33f44c1 100644
> >--- a/include/uapi/linux/p4tc.h
> >+++ b/include/uapi/linux/p4tc.h
> >@@ -2,8 +2,71 @@
> > #ifndef __LINUX_P4TC_H
> > #define __LINUX_P4TC_H
> >
> >+#include <linux/types.h>
> >+#include <linux/pkt_sched.h>
> >+
> >+/* pipeline header */
> >+struct p4tcmsg {
> >+      __u32 pipeid;
> >+      __u32 obj;
> >+};
>
> I don't follow. Is there any sane reason to use header instead of normal
> netlink attribute? Moveover, you extend the existing RT netlink with
> a huge amout of p4 things. Isn't this the good time to finally introduce
> generic netlink TC family with proper yaml spec with all the benefits it
> brings and implement p4 tc uapi there? Please?
>

Several reasons:
a) We are similar to current tc messaging with the subheader being
there for multiplexing.
b) Where does this leave iproute2? +Cc David and Stephen. Do other
generic netlink conversions get contributed back to iproute2?
c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
based. i.e you have:
 COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
P4 programs from the control plane.
d) we have spent many hours optimizing the control to the kernel so i
am not sure what it would buy us to switch to generic netlink..

cheers,
jamal

>
> >+
> >+#define P4TC_MAXPIPELINE_COUNT 32
> >+#define P4TC_MAXTABLES_COUNT 32
> >+#define P4TC_MINTABLES_COUNT 0
> >+#define P4TC_MSGBATCH_SIZE 16
> >+
> > #define P4TC_MAX_KEYSZ 512
> >
> >+#define TEMPLATENAMSZ 32
> >+#define PIPELINENAMSIZ TEMPLATENAMSZ
>
> ugh. A prefix please?
>
> pw-bot: cr
>
> [...]

