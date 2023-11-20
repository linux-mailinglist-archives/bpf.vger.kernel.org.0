Return-Path: <bpf+bounces-15347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E17F0D5D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 09:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0511F21C5E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E2E568;
	Mon, 20 Nov 2023 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nyaM2/Ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83665137
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 00:18:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a0039ea30e0so13940066b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700468289; x=1701073089; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMeb5KzE71YP5ftEukv/JavGwdxFH4sWZOyLbBycOlo=;
        b=nyaM2/Ko6u9fimNdoRIpNthceSa/IBigB76/ssYhPBvKk5ZYfVNErNQ2bl4VKe0O7m
         FnzpkLr9Wf/q2ivPfwDyT06qVyUuU78h1OoHW0QNxLNMe+uG51Ov1AUYbYdgQUJb1mHO
         zl5nS7mhxgan8Lg0/quIn89oFt0cZES6vH88MPIHiCvs1/2se0RvVvWeYt7EKNkiWUcT
         uUkeUi7xCD1rafYutRIX1P2uctc0qYrIl8AMo0gWjR2sewf3z6yIPyFCs4r/g7ZyEJwc
         oe6ej/smP1N3ZOSZ3Ge7bJPyYRXVYderZfmMInUFKsXfxmMSfoeUHQDFDPX9PU4p+tku
         6ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468289; x=1701073089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMeb5KzE71YP5ftEukv/JavGwdxFH4sWZOyLbBycOlo=;
        b=pAANtqhRuc6gheo7NJ2/n2omd1sObv8bEjskshKRJtEuqlFyp5a3s34kV1XjIjzG7c
         jZvsw/DpXcJ+CB1qnCmQr3b5hnj3FgR8H6DEwGic0ycwK3/2L6QWdEdUI9c5ue7wgySt
         9/BPeEazD5NS4Tc96XwVWPETwy04xBAHJsur/FMsOJpAi+M1GXHFveX407AV/E8bEYZB
         eCaTLOdOfJ8K/GZy1FFLLuZDOQD0gvlb3TVgEOFOXcPjsI3Ee4pzthVKkcEfPG2GpfzK
         nFgxbLlGXj69ZW8NMLhoPvWBZvy4LGVF4r/QqK8PhyD3KEVChuSqFHNTeHMEaV4Ee+UB
         pp1w==
X-Gm-Message-State: AOJu0Yz+TAM2canf67hTTnwfHyuUww0Pp/VY32YWLDu3aar+G6PDzxXa
	N/yuicKDMB5+38t0yVWJxbzMPA==
X-Google-Smtp-Source: AGHT+IHjPS8jClwvhsvSJ60skVwvUKYUDNb8tDfVuCoZa8okjdZUGlYcF3Vy065w/IkXuDFQa+IksA==
X-Received: by 2002:a17:906:5357:b0:9ae:6ff4:9f15 with SMTP id j23-20020a170906535700b009ae6ff49f15mr3810115ejo.11.1700468288799;
        Mon, 20 Nov 2023 00:18:08 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009fdaab907fbsm1135274ejb.188.2023.11.20.00.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:18:08 -0800 (PST)
Date: Mon, 20 Nov 2023 09:18:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com, David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
Message-ID: <ZVsWP29UyIzg4Jwq@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho>
 <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>

Fri, Nov 17, 2023 at 01:09:45PM CET, jhs@mojatatu.com wrote:
>On Thu, Nov 16, 2023 at 11:11 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:
>>
>> [...]
>>
>>
>> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>> >index ba32dba66..4d33f44c1 100644
>> >--- a/include/uapi/linux/p4tc.h
>> >+++ b/include/uapi/linux/p4tc.h
>> >@@ -2,8 +2,71 @@
>> > #ifndef __LINUX_P4TC_H
>> > #define __LINUX_P4TC_H
>> >
>> >+#include <linux/types.h>
>> >+#include <linux/pkt_sched.h>
>> >+
>> >+/* pipeline header */
>> >+struct p4tcmsg {
>> >+      __u32 pipeid;
>> >+      __u32 obj;
>> >+};
>>
>> I don't follow. Is there any sane reason to use header instead of normal
>> netlink attribute? Moveover, you extend the existing RT netlink with
>> a huge amout of p4 things. Isn't this the good time to finally introduce
>> generic netlink TC family with proper yaml spec with all the benefits it
>> brings and implement p4 tc uapi there? Please?
>>
>
>Several reasons:
>a) We are similar to current tc messaging with the subheader being
>there for multiplexing.

Yeah, you don't need to carry 20year old burden in newly introduced
interface. That's my point.


>b) Where does this leave iproute2? +Cc David and Stephen. Do other
>generic netlink conversions get contributed back to iproute2?

There is no conversion afaik, only extensions. And they has to be,
otherwise the user would not be able to use the newly introduced
features.


>c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
>based. i.e you have:
> COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
>P4 programs from the control plane.

I'm pretty sure you can achieve the same over genetlink.


>d) we have spent many hours optimizing the control to the kernel so i
>am not sure what it would buy us to switch to generic netlink..

All the benefits of ynl yaml tooling, at least.


>
>cheers,
>jamal
>
>>
>> >+
>> >+#define P4TC_MAXPIPELINE_COUNT 32
>> >+#define P4TC_MAXTABLES_COUNT 32
>> >+#define P4TC_MINTABLES_COUNT 0
>> >+#define P4TC_MSGBATCH_SIZE 16
>> >+
>> > #define P4TC_MAX_KEYSZ 512
>> >
>> >+#define TEMPLATENAMSZ 32
>> >+#define PIPELINENAMSIZ TEMPLATENAMSZ
>>
>> ugh. A prefix please?
>>
>> pw-bot: cr
>>
>> [...]

