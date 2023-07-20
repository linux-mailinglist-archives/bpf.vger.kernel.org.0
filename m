Return-Path: <bpf+bounces-5475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CC75B1FA
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B96D281F31
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533818B04;
	Thu, 20 Jul 2023 15:03:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC41772A;
	Thu, 20 Jul 2023 15:03:57 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E01BC6;
	Thu, 20 Jul 2023 08:03:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66872d4a141so592805b3a.1;
        Thu, 20 Jul 2023 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689865435; x=1690470235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3r2QdODMt24JWTT3oaeZ32YYnCKvklyvwUm1SrldXO8=;
        b=m+3jtebFSl/u6Q9KBLsw2Q9VS5OcZdC/k6SlxqN/lQ5bSyP29lk0BFfI21JluJyNpd
         X3Fvcbj9EdyfbZcbNpJLToun699qXMAXGQSDr1P5zxjLy9C4aUTrKmxvnxV5QcuLO9C4
         jIvm1VlRNOP5OdBlT6FVuOv7v5rEimyFj2Cf8OCUmJAsjWX0e9ncgV0WS7prUpSGfTv0
         m3lfPGlarUtKey3LEf2HbAuGjwbLEl51qC5R6wyXkRj2/oi1KoXiBNKiVgitw5N2Kz0E
         RSyNfc3MbrbTEi6dLldij/Ld5dk4xisKHuCFH6gBzMve04q7olL4QyK+Ts2Tj5UCwEv3
         mA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865435; x=1690470235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r2QdODMt24JWTT3oaeZ32YYnCKvklyvwUm1SrldXO8=;
        b=OxmtM9TH6hrHVnD2YdvRg50T707Fqa0bZnVXZYm99yiwY0oe08v0YgQnKK44Xom/pr
         Xv3KWxhwVqyxMlyLjczZ1Xo5RhBBhshFxIWL1IR1LCIaBwu0RI55v/jJYsBP4IW42zOK
         vHB1S6sUwbPRz2wUXBu7FXE2FUaU09apswS3tORK51CD+czQnBUZYxCCHXDHufDmMqZl
         OF7IVVIk0wVKbUYoZIslBvAtGUN6LkYHYmkK5V/wy7SXaBL8wAZzkgsLyPqyCZPW2lCa
         j2qPBE5i4igM8amNFPr+zWTds4ct1BgNisRCepMR5qfZJN7k/hHujlPv0v0+GxJIrTV4
         fHGQ==
X-Gm-Message-State: ABy/qLYcJ43wL56O9AMGDaLVm6nS8Z0TS+rnH9qhfawOfr9CTuT7YigG
	UZGsreaXqPvoa80LURgjiwQ=
X-Google-Smtp-Source: APBJJlFVtJZKjyiighRxE5mEk35cM8Dd8dreqWkeoTf6MyBSM1enMxAspccBtb4/nTq1g/v5ZTUg6g==
X-Received: by 2002:a05:6a00:cc7:b0:66a:5e6f:8b21 with SMTP id b7-20020a056a000cc700b0066a5e6f8b21mr6724779pfv.2.1689865435391;
        Thu, 20 Jul 2023 08:03:55 -0700 (PDT)
Received: from [192.168.1.12] (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0064f7c56d8b7sm1239911pff.219.2023.07.20.08.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:03:55 -0700 (PDT)
Message-ID: <b86b4a28-29d0-ed2e-ab82-449d1652b10c@gmail.com>
Date: Thu, 20 Jul 2023 23:03:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for xdp
 attaching failure tracepoint
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Yizhou Tang <tangyeechou@gmail.com>, kernel-patches-bot@fb.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20230719125232.92607-1-hffilwlqm@gmail.com>
 <20230719125232.92607-3-hffilwlqm@gmail.com>
 <CAADnVQKxGNNbn-OnQzrbcOfC6c_5tL0PSfZM0y8h_FJ0Pg=sDg@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQKxGNNbn-OnQzrbcOfC6c_5tL0PSfZM0y8h_FJ0Pg=sDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/20 01:39, Alexei Starovoitov wrote:
> On Wed, Jul 19, 2023 at 5:53 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Reuse the XDP program in xdp_dummy.c.
>> + */
>> +
>> +char LICENSE[] SEC("license") = "GPL";
> 
> Do you have a hidden char in the above?
> git considers the last line to be part of the commit log instead
> of part of the patchset and it fails CI.

Sorry for it.

I'll use ./scripts/checkpatch.pl to check it again to make sure no style
issue, then resend this patchset.

Thanks,
Leon

