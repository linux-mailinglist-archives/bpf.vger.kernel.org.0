Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263774E756D
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiCYOx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356285AbiCYOx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:53:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD65DA46
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:52:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so5390500pfe.2
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t5YPY1e3V/OqWE/gdWbIQOms5B9nOpvi3Sw9+QCDpe8=;
        b=DYT13QmpcPrSisR+LbWmwUSGy3rgjjoGeFv0FBljDUKd+3AuA3uwty0lD/ofNmoOfK
         OBido+BlqBsZw4yweX7MH2rCK3kDRjE12dZMdVW4RchCih/t3CwdGDJMR37l3+sJB/QM
         mHBWoKDuRtQaDDBCMMLTPyQV/jagTgqcd1DFSscWDLpXdvLAZQZ+8yFlPEworCiZWEHI
         dFqEkKEpi+avCXry9A2lOKM/xdDWFPD7oSbtu4qlOnxYQ4Onu4iY1QNZW262QY5D+BZ7
         ezKthQsMyq3jTOVwM3NutBIKx/+CwDJWR3LTUWa12xofd16DckfLU9laxdgaOzorGVol
         3ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5YPY1e3V/OqWE/gdWbIQOms5B9nOpvi3Sw9+QCDpe8=;
        b=oyhZoqJCdsPFvw0jly0pJ3Ur2ag+80C1GcEL7x4LpXCBXySL6iMi63uhuAEnL7Gb4t
         aiKMavvFqN4uf3fp0duiWUsukiSU/2T/27bBdiTyd3PWBdPihq0AuflkZI2w+N1lQ6kQ
         h4mKF3wX9lFGtcZqYK4uX4USOYrP7Y+Bw4CAl/7q4PAQSm3/bmvvFA8XAcX0imy4Gccz
         5y+DjH5NrDsmYK3XQjp9HNJUYKi+Vj+4wAjYRQyao+lAFBFVdAwLV37onL5jmg8qczoe
         2oLVlHhOYAIG9Li6V1R3pAJcMIx7r0xFs8Nq84+/1unLoQY1X0oMawF4RApmnuzfkFyb
         JI0w==
X-Gm-Message-State: AOAM5304gXT4XhSpb5qcCn91Nel88EbdsuHgYXvIZ54lbTJYZGES1Y6i
        bvf141yI8JLN5stXDwK1jo+m+v4zveM=
X-Google-Smtp-Source: ABdhPJzVQ9L5IAb2EWOUgYoC9yT74rjfdSlQCQJDYeSAeQjMYCb+9CbBPxGyLmxaXvP5fLZ0woaskw==
X-Received: by 2002:a05:6a00:114e:b0:4c8:55f7:faad with SMTP id b14-20020a056a00114e00b004c855f7faadmr10708040pfm.86.1648219944964;
        Fri, 25 Mar 2022 07:52:24 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm7607878pfc.111.2022.03.25.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:52:24 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:22:22 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 12/13] selftests/bpf: Add C tests for kptr
Message-ID: <20220325145222.jilx53w4kz5emm7c@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-13-memxor@gmail.com>
 <Yjw1dksSQm373PEi@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjw1dksSQm373PEi@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 24, 2022 at 02:40:14PM IST, Jiri Olsa wrote:
> On Sun, Mar 20, 2022 at 09:25:09PM +0530, Kumar Kartikeya Dwivedi wrote:
>
> SNIP
>
> > +static __always_inline
> > +void test_kptr(struct map_value *v)
> > +{
> > +	test_kptr_unref(v);
> > +	test_kptr_ref(v);
> > +	test_kptr_get(v);
> > +}
> > +
> > +SEC("tc")
> > +int test_map_kptr(struct __sk_buff *ctx)
> > +{
> > +	void *maps[] = {
> > +		&array_map,
> > +		&hash_map,
> > +		&hash_malloc_map,
> > +		&lru_hash_map,
> > +	};
> > +	struct map_value *v;
> > +	int i, key = 0;
> > +
> > +	for (i = 0; i < sizeof(maps) / sizeof(*maps); i++) {
> > +		v = bpf_map_lookup_elem(&array_map, &key);
>
> hi,
> I was just quickly checking on the usage, so I might be missing something,
> but should this be lookup to maps[i] instead of array_map ?
>
> similar below in test_map_in_map_kptr
>

My bad, it's a braino. Will fix in v4.
Thanks!

> jirka
>
> > +		if (!v)
> > +			return 0;
> > +		test_kptr(v);
> > +	}
> > +	return 0;
> > +}
> > +
> > +SEC("tc")
> > +int test_map_in_map_kptr(struct __sk_buff *ctx)
> > +{
> > +	void *map_of_maps[] = {
> > +		&array_of_array_maps,
> > +		&array_of_hash_maps,
> > +		&array_of_hash_malloc_maps,
> > +		&array_of_lru_hash_maps,
> > +		&hash_of_array_maps,
> > +		&hash_of_hash_maps,
> > +		&hash_of_hash_malloc_maps,
> > +		&hash_of_lru_hash_maps,
> > +	};
> > +	struct map_value *v;
> > +	int i, key = 0;
> > +	void *map;
> > +
> > +	for (i = 0; i < sizeof(map_of_maps) / sizeof(*map_of_maps); i++) {
> > +		map = bpf_map_lookup_elem(&array_of_array_maps, &key);
> > +		if (!map)
> > +			return 0;
> > +		v = bpf_map_lookup_elem(map, &key);
> > +		if (!v)
> > +			return 0;
> > +		test_kptr(v);
> > +	}
> > +	return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > --
> > 2.35.1
> >

--
Kartikeya
