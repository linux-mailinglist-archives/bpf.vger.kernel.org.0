Return-Path: <bpf+bounces-15353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D47F1424
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED79B1C2187F
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2D1A71B;
	Mon, 20 Nov 2023 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LPp30pGP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F4113
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:16:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548696eac92so2982211a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700486165; x=1701090965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=paXWmZJjkzeTHk9KbxsJ5PCYxiV+9eLWIGBAJo/o7w8=;
        b=LPp30pGP66A+V3hrUWdHnljY/Jl8ueyxCPhErg80swGZg5aDtQzOB5W16XnLYWRaoV
         0Ihe0MgX/9gNPDc8o8ylxQKR2kG6C6rcQy2i5nbfBwmtHTI9xejFC5L1EJuFyWBLYeul
         diLNn31VQtxhw2/980OGnVWn+iJmY4baHgcV7hFTdPBTX+PIe1/jUP2djP4XCOuH5rcF
         QBPm7oxwv/n16I+ldw209C8ZVqnpfwOm/g8bPrYfMQgbxR9KYriAHB43v0xv4BAMjOyd
         sPCtG8mlmMzhojO2f+M16ze2SJz2KgYiA7wJfeAJ7uJB89xtTtb+qXBaLfjDCUZhstuM
         vybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486165; x=1701090965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paXWmZJjkzeTHk9KbxsJ5PCYxiV+9eLWIGBAJo/o7w8=;
        b=wIDwXX2pNFUCjJvgz27twCrDTdtT1Mbqcasb5oKQcXNZXMDGuVSE+sIWlzo+iUN66W
         H9pz+sPCvaw7sc4OQeE+lNPPmDHnh0+BxBWVZ7+n6pfD9rajd0imW4UOiRXzHnf1stgH
         ymHLpGGrpq7eGsWFLazJUheyrAWwCkb/CyD/7yG8t80wwEQJrU4aq+Gae7Vyq0HPGMFK
         OM8hs0IjYvQPXe7nvxm3Auks3nMoDbTqz5PGLWkfJlu2TyaJRgAh3gInIA91qzHFD+/1
         uXk9cfSb7uX7VMBy5ppA1SiET88GMyPGoUc5yQJsN+ioRg7wBugXB044npc5Z+t4OV//
         ywuA==
X-Gm-Message-State: AOJu0Yz/QQMmjIvqNFW47G/LMqCCB3V2ezA83zuqtGrETRzBlpIcvF7p
	NGXfXiRU3hphurxymL3tUqBxPw==
X-Google-Smtp-Source: AGHT+IEWyPu++B3DE+4d8255KgTG/8MpKf+RTbXjZHmp0gcLahMNvhvPxYv5IOqWBy5p1Lr9nmPYfQ==
X-Received: by 2002:a05:6402:2d7:b0:53d:b59c:8f91 with SMTP id b23-20020a05640202d700b0053db59c8f91mr5458780edx.27.1700486165430;
        Mon, 20 Nov 2023 05:16:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm3732932edi.28.2023.11.20.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:16:04 -0800 (PST)
Date: Mon, 20 Nov 2023 14:16:03 +0100
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
Message-ID: <ZVtcEwICZHsTtija@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho>
 <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
 <ZVsWP29UyIzg4Jwq@nanopsycho>
 <CAM0EoM=nANF_-HaMKmk0j6JXqGeuEUZVU3fxZp4VoB9GzZwjUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=nANF_-HaMKmk0j6JXqGeuEUZVU3fxZp4VoB9GzZwjUQ@mail.gmail.com>

Mon, Nov 20, 2023 at 01:48:14PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 20, 2023 at 3:18 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Nov 17, 2023 at 01:09:45PM CET, jhs@mojatatu.com wrote:
>> >On Thu, Nov 16, 2023 at 11:11 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:
>> >>
>> >> [...]
>> >>
>> >>
>> >> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>> >> >index ba32dba66..4d33f44c1 100644
>> >> >--- a/include/uapi/linux/p4tc.h
>> >> >+++ b/include/uapi/linux/p4tc.h
>> >> >@@ -2,8 +2,71 @@
>> >> > #ifndef __LINUX_P4TC_H
>> >> > #define __LINUX_P4TC_H
>> >> >
>> >> >+#include <linux/types.h>
>> >> >+#include <linux/pkt_sched.h>
>> >> >+
>> >> >+/* pipeline header */
>> >> >+struct p4tcmsg {
>> >> >+      __u32 pipeid;
>> >> >+      __u32 obj;
>> >> >+};
>> >>
>> >> I don't follow. Is there any sane reason to use header instead of normal
>> >> netlink attribute? Moveover, you extend the existing RT netlink with
>> >> a huge amout of p4 things. Isn't this the good time to finally introduce
>> >> generic netlink TC family with proper yaml spec with all the benefits it
>> >> brings and implement p4 tc uapi there? Please?
>> >>
>> >
>> >Several reasons:
>> >a) We are similar to current tc messaging with the subheader being
>> >there for multiplexing.
>>
>> Yeah, you don't need to carry 20year old burden in newly introduced
>> interface. That's my point.
>
>Having a demux sub header is 20 year old burden? I didnt follow.

You don't need the header, that's my point.


>
>>
>> >b) Where does this leave iproute2? +Cc David and Stephen. Do other
>> >generic netlink conversions get contributed back to iproute2?
>>
>> There is no conversion afaik, only extensions. And they has to be,
>> otherwise the user would not be able to use the newly introduced
>> features.
>
>The big question is does the collective who use iproute2 still get to
>use the same tooling or now they have to go and learn some new
>tooling. I understand the value of the new approach but is it a
>revolution or an evolution? We opted to put thing in iproute2 instead
>for example because that is widely available (and used).

I don't see why iproute2 user facing interface would be any different
depending on if you user RTnetlink or genetlink as backend channel...


>
>>
>> >c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
>> >based. i.e you have:
>> > COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
>> >P4 programs from the control plane.
>>
>> I'm pretty sure you can achieve the same over genetlink.
>>
>
>I think you are right.
>
>>
>> >d) we have spent many hours optimizing the control to the kernel so i
>> >am not sure what it would buy us to switch to generic netlink..
>>
>> All the benefits of ynl yaml tooling, at least.
>>
>
>Did you pay close attention to what we have? The user space code is
>written once into iproute2 and subsequent to that there is no
>recompilation  of any iproute2 code. The compiler generates a json
>file specific to a P4 program which is then introspected by the
>iproute2 code.

Right, but in real life, netlink is used directly by many apps. I don't
see why this is any different.

Plus, the very best part of yaml from user perpective I see is,
you just need the kernel-git yaml file and you can submit all commands.
No userspace implementation needed.


>
>
>cheers,
>jamal
>
>>
>> >
>> >cheers,
>> >jamal
>> >
>> >>
>> >> >+
>> >> >+#define P4TC_MAXPIPELINE_COUNT 32
>> >> >+#define P4TC_MAXTABLES_COUNT 32
>> >> >+#define P4TC_MINTABLES_COUNT 0
>> >> >+#define P4TC_MSGBATCH_SIZE 16
>> >> >+
>> >> > #define P4TC_MAX_KEYSZ 512
>> >> >
>> >> >+#define TEMPLATENAMSZ 32
>> >> >+#define PIPELINENAMSIZ TEMPLATENAMSZ
>> >>
>> >> ugh. A prefix please?
>> >>
>> >> pw-bot: cr
>> >>
>> >> [...]

