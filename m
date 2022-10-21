Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95F2607899
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJUNiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJUNiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 09:38:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8342565F8;
        Fri, 21 Oct 2022 06:37:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so5054623wms.0;
        Fri, 21 Oct 2022 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgF3erMvkQ/nPTqAM5KhZUMocLuItW+UzQkK48NYCD8=;
        b=K8jPLGL63Olt1F7lCbQ3UoyvbJzrlSn0DT9M2HXdMxJfG00nf8CL5piElNVBAHol7X
         YGMjKMIViUxW0He6lJvEdMwcGa8rLsAcetT4E21ee5j3VxcYhozjamFO0L9agSwHlDvy
         ExsENlfCbL6KJYMQVTAVCYKu96teeQCwipCiImB9eLYzK1WJY4ksSTOqkFggAzzN94i6
         QL4pfNqxOM04Szhc5Q4QGTEagdCRYCj2HmBr0NhRfnHF33VV3D78WIuLHJ8kusMD5QMU
         rPxHmbm7paK/rv/VoJo6qOaEKfhW9jxgLPuVJTs5puzOdvs4NsuK5/QEMBigWH2r7B1e
         16cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgF3erMvkQ/nPTqAM5KhZUMocLuItW+UzQkK48NYCD8=;
        b=f6NketbLltXSUXhXw0KwN9kPDvIIdNhPLLIcb2e+V08uGpVnLtJx2aFzZ5zydOmOQx
         cdv4WLogHgHcDgjy2G4sb+kTFNI64vNp8AzmX5IkHzZriWpqh9z02Ho6E0J/7kJVG+bl
         CthHP3dpIEFzzeBK84MK0kkD/K5W+daXv/CB83FTqK7aNf9ws47xyPdT0/Gn+2fToaoy
         L7Frikr+NPlQ42h9V5GWvQGFJP9+EAcJcHkmtQslUeftvo/Ird9pqJWOm7aLQYJLMN4o
         OT0SnU1GgR7krmmz4/90n22O1DR8TjlqkXHXR5hZhaBDKOCLcqEPImGV5h/gOpTBB/sT
         AMiQ==
X-Gm-Message-State: ACrzQf0qc0IglFg+CQQWD46FIE6NdrxslmdJg51lJnEzn5Qkp1D1lSf8
        YCMBFaIZ7pZcD1Bksc312LU=
X-Google-Smtp-Source: AMsMyM6FTDgQU5Wss7fI1bkRxVh0HeeWO6FzGMbf4dgxE5NXB2hH7qmsm0xZwT//hruLWB525wnBDw==
X-Received: by 2002:a7b:cc0c:0:b0:3c5:a58f:afbc with SMTP id f12-20020a7bcc0c000000b003c5a58fafbcmr13323181wmh.169.1666359477416;
        Fri, 21 Oct 2022 06:37:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:cc4f:5367:93c1:b0d5])
        by smtp.gmail.com with ESMTPSA id 1-20020a1c1901000000b003bf3fe1d0c4sm2520459wmz.22.2022.10.21.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:37:56 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        dave@dtucker.co.uk
Subject: Re: [PATCH bpf-next v7 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <CAADnVQLRyP2hgvmLubnCdZuPHofQ8CGRiGq_a2FQy_ZzRimiEw@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 19 Oct 2022 17:05:32 -0700")
Date:   Fri, 21 Oct 2022 14:37:38 +0100
Message-ID: <m2fsfhuwkd.fsf@gmail.com>
References: <20221007162755.36677-1-donald.hunter@gmail.com>
        <20221007162755.36677-2-donald.hunter@gmail.com>
        <CAADnVQLRyP2hgvmLubnCdZuPHofQ8CGRiGq_a2FQy_ZzRimiEw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Oct 7, 2022 at 9:39 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Actually all values are rounded up to 8.
> Maybe we should say that all array elements are aligned to 8
> instead of values are rounded?
> Because values_size=4 stays as 4 from bpf prog pov.
> The progs cannot access bytes 5,6,7,8 though that memory is consumed.

Agreed, I will reword to mention alignment instead of rounding.

>> +When using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` the ``bpf_map_update_elem()`` and
>> +``bpf_map_lookup_elem()`` helpers automatically access the hash slot for the
>> +current CPU.
>
> hash slot?
> the copy paste went wrong? :)

Good catch.

>> +    int bpf_prog(struct __sk_buff *skb)
>> +    {
>> +            int index = load_byte(skb,
>> +                                  ETH_HLEN + offsetof(struct iphdr, protocol));
>> +            long *value;
>
> Please avoid using deprecated instructions like load_byte in examples.

Will rewrite to use bpf_skb_load_bytes.

>> +    int create_array() {
>> +            int fd;
>> +            LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
>
> Add empty line pls.

Ack.

>> +    int lookup(int fd) {
>> +            __u32 index = 42;
>> +            long value;
>> +            int ret = bpf_map_lookup_elem(fd, &index, &value);
>
> Empty line pls.
> Or better yet do 'int ret;'
> and ret = bpf_map... on a separate line.

Ack.

>> +    int lookup(int fd) {
>> +            int ncpus = libbpf_num_possible_cpus();
>> +            __u32 index = 42, j;
>> +            long values[ncpus];
>> +            int ret = bpf_map_lookup_elem(fd, &index, &values);
>
> same here.

Ack. Thansk for the review!
