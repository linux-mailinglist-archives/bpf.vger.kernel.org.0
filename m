Return-Path: <bpf+bounces-15199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0499E7EE4FC
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EA71C20928
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F13BB3E;
	Thu, 16 Nov 2023 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Hn2vy02P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92A1A8
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 08:11:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso8641425e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700151066; x=1700755866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FrAh6VZJs4Mwoi9RIsxy0fEAEPO1KkRo4SmyQeSET4=;
        b=Hn2vy02PJ5AsZqBSHxrMq4juswMYuPznYe28tTWbebHVYyJHzfPANPiY7rcttlU2a3
         6LgYbYYmzOYDHka1/1BzeUOj4WfHOWBddmKmLfp+OW+atvMv3dK1tCnh9FEur+qD80Pn
         iNR+zSpU0Dfj+KQMQaRs1fBL+2ScIYmsWDvKjIyXb/txTyWBbXb0/A6sxXQxylDsZAEA
         nDFLiNpI/AuPSLYpoy8Z8uZYaloNjl0jAMfB0pfIMFezt27/rCP8aeNVDd96OBg6JjCO
         33O6jaLS4pSnQCfr47AiWnFtUE9F9PQ5gf71jbYYPdtGRRjRnK250e67KnzgDn3R4Tz1
         Ja8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151066; x=1700755866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FrAh6VZJs4Mwoi9RIsxy0fEAEPO1KkRo4SmyQeSET4=;
        b=Lr9mi2Ui7z4+KpaHUaTPRBvvsy7ePxZgxUoEx2jf4N5bYVsdpZ2tBVSK7gHNZLvluL
         pNx/uf0+NRu/XO/2XZjhxS/bUIRZI2TfBEwORTfPNOMY5M7AqLe8AScEq+jJdnVfGaZ8
         uWcS5hsTzd1LhF4PRELZ4V9s2o2r9Kf6xaA/RPq8EzRsbiECCrujUJ0rttx9ChC6TZ/y
         v4RuxJREwGHoKcAyhXAIXPnr2OTKogQQhxvciNmlm4TBhZFNMXgQ7Dtx2Bwy7iid1RTi
         wXRV6fSV09YUyGotgmu2TY6Az8rxUF1D47ZANdSDJjHsG6T7lwLnqyKvVtdwwVP+R6Nl
         8I7g==
X-Gm-Message-State: AOJu0Yx0H1dn4BnN40/+Uo5WAtddk5ID9EVEFfZAHfagfVwR/8mMsZJ0
	yu5l1outLrUKDlUOfHiZN3XLRA==
X-Google-Smtp-Source: AGHT+IH61uvUUEzsBFgCjsCDVmtEKg+RtvAK/2QN8TjqwM+xkBsR6BCisHnnTQA/kSCK1y9d7P4UMw==
X-Received: by 2002:a5d:47cd:0:b0:331:4a30:a34d with SMTP id o13-20020a5d47cd000000b003314a30a34dmr10893482wrc.35.1700151066047;
        Thu, 16 Nov 2023 08:11:06 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b0032dbf32bd56sm14028188wrs.37.2023.11.16.08.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:11:05 -0800 (PST)
Date: Thu, 16 Nov 2023 17:11:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
Message-ID: <ZVY/GBIC4ckerGSc@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-10-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116145948.203001-10-jhs@mojatatu.com>

Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:

[...]


>diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>index ba32dba66..4d33f44c1 100644
>--- a/include/uapi/linux/p4tc.h
>+++ b/include/uapi/linux/p4tc.h
>@@ -2,8 +2,71 @@
> #ifndef __LINUX_P4TC_H
> #define __LINUX_P4TC_H
> 
>+#include <linux/types.h>
>+#include <linux/pkt_sched.h>
>+
>+/* pipeline header */
>+struct p4tcmsg {
>+	__u32 pipeid;
>+	__u32 obj;
>+};

I don't follow. Is there any sane reason to use header instead of normal
netlink attribute? Moveover, you extend the existing RT netlink with
a huge amout of p4 things. Isn't this the good time to finally introduce
generic netlink TC family with proper yaml spec with all the benefits it
brings and implement p4 tc uapi there? Please?


>+
>+#define P4TC_MAXPIPELINE_COUNT 32
>+#define P4TC_MAXTABLES_COUNT 32
>+#define P4TC_MINTABLES_COUNT 0
>+#define P4TC_MSGBATCH_SIZE 16
>+
> #define P4TC_MAX_KEYSZ 512
> 
>+#define TEMPLATENAMSZ 32
>+#define PIPELINENAMSIZ TEMPLATENAMSZ

ugh. A prefix please?

pw-bot: cr

[...]

