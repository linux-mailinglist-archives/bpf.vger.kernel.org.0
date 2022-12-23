Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E45654F57
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 11:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiLWKvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 05:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLWKvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 05:51:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204AEBB7
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 02:51:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o5so4249804wrm.1
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUWOtdUH/FK6dlyyQTRzoX4Sh0nW9DKrQ5zYKQvxpFU=;
        b=elDT9SSTCYJwpX1IJbgt/hKt2N+JNOnJpDRWNMTjq1U8+baoAy730MHcB5CbB9xic+
         Iz2DOM3t9JF4HzVv9A9zOY6WX/BmOUNGaTaSvM6SoXHgxC2qcHlpzdLM4Xmj/xKPAWSi
         JF9jFZNRAlAYGQ4NpUuj8WdJIzsyZM6ZdvrvRDzybqajyY/14AFsytT2WZZMWK4xO5Sn
         AWXZCiniLxYWuUQJqVZjiuboBFOA7qN3+i+s13Q0aopecvHJH9xVOlUHFwr4uE/Bz0d4
         5VpDIflUG54W5MXZjHDD4KkEenR7SOz2sioQl8xh6UxnpsFZJ9/IVcJ2nJneiA/pT0Qn
         EvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUWOtdUH/FK6dlyyQTRzoX4Sh0nW9DKrQ5zYKQvxpFU=;
        b=0XsIDCYjieeBcRcgs0P0tvOO8BZgzgLYWBJHY9med9l0YE2Ky25BCXMX3/9TniApC3
         rMA+D0onoLYwKBE/N27ETh86Chbg1tD9Y2rLQ2KkaoxXidc+ecngKdLH7UtYsBfZY2hS
         syT0nY/LnXbccgb8MdNUoYoWZj/RTco5YURVgOuiJ/MUDFy4lJiSe6luFwwJ6ed2XLEw
         G5aKkaJqoSxnJ7BSnwyhxXbeTn9l6l9BxbTiTDwFZfrhFwEHiSJmLH/m0sB+ski3Phwi
         Fc8tflo/+KmbqGMQMmxrKlNfCaxzjQRJbQDbbc1QJRriu/NWzoSHlIjNaGyL5mnQKHq5
         AZ+g==
X-Gm-Message-State: AFqh2kovC3gh5v0EcWVKdxZ/gL11+lbE9hqUWqyZIY1B4qxJS3XJqv/e
        WX7P8R0z0MHqRcwpaVNGCuw=
X-Google-Smtp-Source: AMrXdXvKT4FLelieQBXnujk8dewb7kPihUuwPzrNoDmQ3unvPeeIhL6nvRz8OCPTP10D9os/xGrVgQ==
X-Received: by 2002:a5d:6a4c:0:b0:242:5878:291e with SMTP id t12-20020a5d6a4c000000b002425878291emr6192106wrw.51.1671792688652;
        Fri, 23 Dec 2022 02:51:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe64a000000b00242271fd2besm2873217wrn.89.2022.12.23.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:51:28 -0800 (PST)
Date:   Fri, 23 Dec 2022 13:51:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
        bpf@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic
 to non-owning ref semantics
Message-ID: <202212171800.H94NtsOB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217082506.1570898-3-davemarchevsky@fb.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dave,

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/BPF-rbtree-next-gen-datastructure/20221217-162646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20221217082506.1570898-3-davemarchevsky%40fb.com
patch subject: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic to non-owning ref semantics
config: x86_64-randconfig-m001
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
kernel/bpf/verifier.c:6275 reg_find_field_offset() warn: variable dereferenced before check 'reg' (see line 6274)

vim +/reg +6275 kernel/bpf/verifier.c

4ed17b8d6842ba Dave Marchevsky 2022-12-17  6268  static struct btf_field *
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6269  reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6270  {
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6271  	struct btf_field *field;
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6272  	struct btf_record *rec;
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6273  
4ed17b8d6842ba Dave Marchevsky 2022-12-17 @6274  	rec = reg_btf_record(reg);
4ed17b8d6842ba Dave Marchevsky 2022-12-17 @6275  	if (!reg)

Is this supposed to test rec instead of reg?

4ed17b8d6842ba Dave Marchevsky 2022-12-17  6276  		return NULL;
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6277  
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6278  	field = btf_record_find(rec, off, fields);
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6279  	if (!field)
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6280  		return NULL;
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6281  
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6282  	return field;
4ed17b8d6842ba Dave Marchevsky 2022-12-17  6283  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

