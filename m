Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847A04B6822
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiBOJrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 04:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiBOJrt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 04:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0341E6C33
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644918458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwvWeASu6WXtk75r3ZpXR2PmZ4CaNEX5pp7rMM04oMk=;
        b=jEF+vFcONXN4tvaP1nCVgcqhQDJ33Tr89va2MoSg49aIzyAmeUfEAF1iIT2SfqI298lLrl
        lpn6qPdBEKlLz0CjUsHcabmH82IPQry3mdXsAF9yz4QwUmDY0V1B86F8nTtV6TliCHqLpe
        E/tzRTJ9jn/2XFMpL0lMubYyH0/5m7c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-LBRXcddXP9SAqCoGrsV4KQ-1; Tue, 15 Feb 2022 04:47:37 -0500
X-MC-Unique: LBRXcddXP9SAqCoGrsV4KQ-1
Received: by mail-ej1-f70.google.com with SMTP id q3-20020a17090676c300b006a9453c33b0so6998658ejn.13
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 01:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SwvWeASu6WXtk75r3ZpXR2PmZ4CaNEX5pp7rMM04oMk=;
        b=s7AfY3lAQZsyCv52ZzNcZvFlQl9Y35LQXHwxxMppxSvppX7JxHc8S9BNfapEOK+rEq
         0WfvgRfgAFoqR+EefQvpdXGsEalr0980EIP1ubQdmRhqqWC1EaNSo/s36Ltfi05hRqC6
         fCNIQq66yzrC/XjvCSl1wG/QKBuLp9iQmaHtI+mGazWK5kDcBYQl0KtH90CTZVgfJyS5
         S7u0pJr9a1lixuC9xCVeWEulbXKcMU8qWWotPCYIOZhBR6F28SGAilIeg24jYZz7W1y3
         Che2XhH2kdzPrtMGGk5c4XmmLixgTuOVlFfiU+ccR7B8ryPJH9U/EokKwURaDgbyitXo
         Ad9Q==
X-Gm-Message-State: AOAM532fdEtbgdYF31WANDclmWOFtBk2X6URZOap6mNxWAmjSaq0AaFT
        lAOQT72zy37wmX6GIGbHL3vcTdQr1nuXLdMUtdYnuzgo+bh0+8vYjT/8/ctDXfH96UeQoynjdzq
        5mXPddzaAvl+Z
X-Received: by 2002:a17:906:7a18:: with SMTP id d24mr2359632ejo.232.1644918456040;
        Tue, 15 Feb 2022 01:47:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE4lQhejJZezEIhm1Dz63I1RLd7aAJaUYILWarQzoC/wcee0fF9OsicbNQEWv/eDz0oy9RxA==
X-Received: by 2002:a17:906:7a18:: with SMTP id d24mr2359616ejo.232.1644918455837;
        Tue, 15 Feb 2022 01:47:35 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 23sm2370018ejf.215.2022.02.15.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:47:35 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:47:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yinjun Zhang <yinjun.zhang@corigine.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        niklas.soderlund@corigine.com,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
Message-ID: <Ygt2tfdfRZIQwx5W@krava>
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 08, 2022 at 12:00:25AM +0800, Yinjun Zhang wrote:
> When reworking btf__get_from_id() in commit a19f93cfafdf the error
> handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
> if bpf_btf_get_fd_by_id() failed the error would not be propagated to
> callers of btf__get_from_id(), after the rework it is. This lead to a
> change in behavior in print_key_value() that now prints an error when
> trying to lookup keys in maps with no btf available.
> 
> Fix this by following the way used in dumping maps to allow to look up
> keys in no-btf maps, by which it decides whether and where to get the
> btf info according to the btf value type.
> 
> Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> Signed-off-by: Simon Horman <simon.horman@corigine.com>

once this one gets merged, I'd send this fix on top of that:
  https://lore.kernel.org/bpf/20220204225823.339548-3-jolsa@kernel.org/

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  tools/bpf/bpftool/map.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index cc530a229812..4fc772d66e3a 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
>  	json_writer_t *btf_wtr;
>  	struct btf *btf;
>  
> -	btf = btf__load_from_kernel_by_id(info->btf_id);
> -	if (libbpf_get_error(btf)) {
> -		p_err("failed to get btf");
> +	btf = get_map_kv_btf(info);
> +	if (libbpf_get_error(btf))
>  		return;
> -	}
>  
>  	if (json_output) {
>  		print_entry_json(info, key, value, btf);
> -- 
> 1.8.3.1
> 

