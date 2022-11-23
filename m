Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44A6361BE
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiKWO2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiKWO0n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70108FB1A
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669213468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+HXGpPooIMe6sNdUgSAzfW/8NtY/urg9PVU34CjlakY=;
        b=OBORLP989/dOAQ6smlajHowVC8lvpRL6wjZKpCCksfRLrFIUIX/YvR0/phep7PUmWv/GMd
        vXwEpbY7XRbcCtLICuYVMTvxk2DtmQXCdT5Ek8hQ7kT7p/icUVj2kD5L6kKu8YpN55WfzS
        n9muon6N1tamd7zD1WADJVsMA0ohv00=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-OVDeiuaBN-y__UnZppBOYw-1; Wed, 23 Nov 2022 09:24:26 -0500
X-MC-Unique: OVDeiuaBN-y__UnZppBOYw-1
Received: by mail-ej1-f69.google.com with SMTP id ne36-20020a1709077ba400b007aeaf3dcbcaso9904159ejc.6
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HXGpPooIMe6sNdUgSAzfW/8NtY/urg9PVU34CjlakY=;
        b=chIt3E9FLBU9oCapU+3JWkgaaBEYyL8pT7iJNX2EPMlQluonS24dwYIGAZTYwlB71y
         N6In5TOnS4unM9NbmpnM9SMaYPR9dObpm3H68fThiqEfwrVz1SDvKSE5TnFb/dgQbTTv
         IsZIP69OJa947U88igrQqk7B+sKQF2MZtfKME7WzobT7QU/U7HPPh9flxRPJ94NtRcsZ
         vikltxHvsOywBEnwGEyzuxlKNS8AdYuU9S1FQMyPnaVqywhnpi8CzWrKKlwSdJzwjkar
         MyjWouV6fyEq874TGgGNkHp9BNrPHgQFxm8uDkA6HtCrIMXKGRpDVN1Yoj07sdsVlzbP
         PjLQ==
X-Gm-Message-State: ANoB5plI5/KlxHFIMmRDkRhAya24tUaE9umdXSb0yb/gQlZzBBTWHuaz
        zXbC50ZMuUKqvSxDssesdKDIA7RwqMYG1flFqBYtgYu1TggMzP61UTQFPNKXsrQ6p/6AaqP5rRG
        K0WHn7ZbB2cmv
X-Received: by 2002:a17:906:b749:b0:7b6:6e0a:17dd with SMTP id fx9-20020a170906b74900b007b66e0a17ddmr8326451ejb.590.1669213465281;
        Wed, 23 Nov 2022 06:24:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4TlTtotUdHzjVrM8lE5ZJ5PpqfjRzrePg1TyOkbZEtVq8E4QPMbh+AfzYYZrhKKTyMbjQLbQ==
X-Received: by 2002:a17:906:b749:b0:7b6:6e0a:17dd with SMTP id fx9-20020a170906b74900b007b66e0a17ddmr8326415ejb.590.1669213464920;
        Wed, 23 Nov 2022 06:24:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ee47-20020a056402292f00b00468f7bb4895sm7369868edb.43.2022.11.23.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:24:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 81EF07D5114; Wed, 23 Nov 2022 15:24:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] [PATCH bpf-next v2 2/8] bpf: XDP metadata RX kfuncs
In-Reply-To: <20221121182552.2152891-3-sdf@google.com>
References: <20221121182552.2152891-1-sdf@google.com>
 <20221121182552.2152891-3-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Nov 2022 15:24:23 +0100
Message-ID: <87a64hvje0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -15181,6 +15200,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		return -EINVAL;
>  	}
>  
> +	if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_XDP) {
> +		int imm = fixup_xdp_kfunc_call(env, insn->imm);
> +
> +		if (imm) {
> +			insn->imm = imm;
> +			return 0;

This needs to also set *cnt = 0 before returning; otherwise the verifier
can do some really weird instruction rewriting that leads to the JIT
barfing on invalid instructions (as I just found out while trying to
test this).

-Toke

