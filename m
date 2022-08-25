Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0948A5A14F8
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiHYO65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiHYO64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 10:58:56 -0400
Received: from 10.mo552.mail-out.ovh.net (10.mo552.mail-out.ovh.net [87.98.187.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F6B5A78
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 07:58:55 -0700 (PDT)
Received: from mxplan6.mail.ovh.net (unknown [10.108.4.35])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id CC3AF2729F;
        Thu, 25 Aug 2022 14:23:01 +0000 (UTC)
Received: from jwilk.net (37.59.142.100) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 25 Aug
 2022 16:22:58 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-100R0039edb75d6-ed00-4167-8455-8a71bd083319,
                    7E6AE0283D4A57E58743953EE7A8FB9473A8110D) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.184
Date:   Thu, 25 Aug 2022 16:22:56 +0200
From:   Jakub Wilk <jwilk@jwilk.net>
To:     Quentin Monnet <quentin@isovalent.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        <bpf@vger.kernel.org>, Alejandro Colomar <alx.manpages@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        <linux-man@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Fix a few typos in BPF helpers
 documentation
Message-ID: <20220825142256.of3glbnwi77kgkzo@jwilk.net>
References: <20220825110216.53698-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220825110216.53698-1-quentin@isovalent.com>
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG5EX1.mxp6.local (172.16.2.41) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 43b2c289-649c-4bcf-8c4c-9677574ae55c
X-Ovh-Tracer-Id: 9639110581004851076
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejfedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujghisehttdertddttddvnecuhfhrohhmpeflrghkuhgsucghihhlkhcuoehjfihilhhksehjfihilhhkrdhnvghtqeenucggtffrrghtthgvrhhnpeeutddtteelhfffuddvhefgfedujeeltdekheduveekkeelfeduuedvgeejudffgfenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghniedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjfihilhhksehjfihilhhkrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqmhgrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Quentin Monnet <quentin@isovalent.com>, 2022-08-25 12:02:
>--- a/tools/include/uapi/linux/bpf.h
>+++ b/tools/include/uapi/linux/bpf.h
>@@ -79,7 +79,7 @@ struct bpf_insn {
> /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
> struct bpf_lpm_trie_key {
> 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
>-	__u8	data[0];	/* Arbitrary size */
>+	__u8	data[];	/* Arbitrary size */
> };

This hunk picks the change from 94dfc73e7cf4 ("treewide: uapi: Replace 
zero-length arrays with flexible-array members").

A bit weird to see it in a spelling-fix patch though. Wouldn't it be 
better to put it in a separate one?

-- 
Jakub Wilk
