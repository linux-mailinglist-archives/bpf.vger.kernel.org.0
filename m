Return-Path: <bpf+bounces-11465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED77BA7CE
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E74BA1C20978
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB363AC08;
	Thu,  5 Oct 2023 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcGKRktz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4E37C9D;
	Thu,  5 Oct 2023 17:20:55 +0000 (UTC)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6FB9B;
	Thu,  5 Oct 2023 10:20:52 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fd60f40ebso39995939f.1;
        Thu, 05 Oct 2023 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696526451; x=1697131251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAnE8YGBmiPVkN5gzt7KEanEHBNDCheNt23dazaDoSM=;
        b=PcGKRktzZYZHFVvUYLVfwPg+Nhq3O/jWcOV6FA2A5DoWmHeuaftEHqQH+temzSbXw0
         DTH4COlntVdBvyHlxyPb1tlPoi39LXKiqG9dMuxnjsz4zG2aLrePKW0mF+N103OzrQbf
         wmH3b1bB8X9EQhBTcoNF0dzEjv6SCP386cAfPWIi2bbPsEnP8ohZ4hPeIccINXT2UujN
         jwillgPkAP9yBrqaIzWifajwsRJ4A5Yk+ZmfcvRtDB+XJbKKKejP8X6IlVUvVENGVqwW
         C7BS33rq5CylsGlJ0e43vTAKgixYLmfsWy/KK7iKgrEgIHjbR9E2vu9fd7LgeQ0hPvna
         eQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526451; x=1697131251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAnE8YGBmiPVkN5gzt7KEanEHBNDCheNt23dazaDoSM=;
        b=TI+CQGK3K1L4MfaOZqXIuE/UVcSZIolGAsIayzwTLKlCpDJwMZ59AgpiIssaLtNxCf
         AZ0QfUMFI1JK8C8nV47wwHK8jK9nMXGZHh26Zhowgw5Z86zG4aneraF3IRHlbDjX3TcX
         knv2rvyICdt5DfHZX89dj7Zwcj2Iozec6ofhr2z9QWYAT7Nv22bvQasZW+ARMVUfVuY9
         kd0CzEeRjSmiu3sTqaq8bYTAU9cV3oTmnYVKbQMhzSDJjjDdrtXx59b4xYILxlMZ1Ly+
         1RPBuimizkxAPgmFce1YD9qpreZ/hcSvDhv6G7QLmX/NITeLmDOEqSbwFkNWPR4dQ8/x
         3N9Q==
X-Gm-Message-State: AOJu0YyX6VJaPGNbWILtI8LZitRq7ioRrDMKEhAFBlikv6EXkAuyNJcM
	GxIgukogmNtG/mlaKtf4Z8y4zN2W4HstRg==
X-Google-Smtp-Source: AGHT+IGiPxcoNEq+Kvx3A8ekiuNOYMO/KiaUOE4otIjWL9+QNElOR+S0S9jkUhfV6b3sekBC6iZHrQ==
X-Received: by 2002:a6b:fa01:0:b0:792:82f8:73fe with SMTP id p1-20020a6bfa01000000b0079282f873femr2491281ioh.3.1696526451434;
        Thu, 05 Oct 2023 10:20:51 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:ce2:4ffb:eae7:c0cc? ([2601:282:1e82:2350:ce2:4ffb:eae7:c0cc])
        by smtp.googlemail.com with ESMTPSA id g4-20020a6be604000000b007a2a5caf040sm55173ioh.32.2023.10.05.10.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:20:51 -0700 (PDT)
Message-ID: <0be2e89e-8a08-e52c-fecd-3064262c2ecb@gmail.com>
Date: Thu, 5 Oct 2023 11:20:49 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 Willem de Bruijn <willemb@google.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Simon Horman <simon.horman@corigine.com>, Tariq Toukan
 <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
 <20230927075124.23941-10-larysa.zaremba@intel.com>
 <20231003053519.74ae8938@kernel.org>
 <8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
 <20231004110850.5501cd52@kernel.org>
 <e4bbe997-326f-b6cf-b6d6-f0a24f5aef39@intel.com>
 <20231005101604.33b382d8@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231005101604.33b382d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/5/23 11:16 AM, Jakub Kicinski wrote:
> On Thu, 5 Oct 2023 18:58:33 +0200 Alexander Lobakin wrote:
>>> No unsharing - you can still strip it in the driver.  
>>
>> Nobody manually strips VLAN tags in the drivers. You either have HW
>> stripping or pass VLAN-tagged skb to the stack, so that skb_vlan_untag()
>> takes care of it.
> 
> Isn't it just a case of circular logic tho?
> We don't optimize the stack for SW stripping because HW does it.
> Then HW does it because SW is not optimized.
> 
>>> Do you really think that for XDP kfunc call will be cheaper?  
>>
>> Wait, you initially asked:
>>
>> * discussion about the validity of VLAN stripping as an offload?
>> * Do people actually care about having it enabled?
>>
>> I did read this as "do we still need HW VLAN stripping in general?", not
>> only for XDP. So I replied for "in general" -- yes.
>> Forcefully disabling stripping when XDP is active is obscure IMO, let
>> the user decide.
> 
> Every time I'm involved in conversations about NIC datapath host
> interfaces I cringe at this stupid VLAN offload. Maybe I'm too
> daft to understand it's amazing value but we just shift 2B from
> the packet to the descriptor and then we have to worry about all
> the corner cases that come from vlan stacking :(

4B (vlan tci + protocol).

VLAN stripping in S/W and pushing the header on Tx is measurable and
does have a noticeable performance impact.

XDP programs need to co-exist with enabled offloads. If the tag is not
stripped, XDP program needs to handle it. If the tag is stripped, the
XDP program needs to access to the value.


