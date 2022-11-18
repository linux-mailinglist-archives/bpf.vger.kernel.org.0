Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC762F65A
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiKRNgn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 08:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242177AbiKRNgU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 08:36:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D47D91520;
        Fri, 18 Nov 2022 05:34:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p21so4556127plr.7;
        Fri, 18 Nov 2022 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RPbQDiX/Zy5K2QrYqqrxGkL0efikkW2IcEvpnZvUnM=;
        b=afa5CPOEpf7VX42vv4gmHNqu8Mhvks8EOB7Qfdle9fDHl+pbzv/c94ufgP7S7YfIZY
         /g0KJWnHuNaOXzQ3aXeFp3wEkYOb8fGnma5DGncynujm2QkwA+VqlG7Q4PLoxHmPCDLp
         BKxByYCyFgkRA/GX3hpIhc0BZ3tO4Yh7tSscaKkdLgyCxUuNoOnvgTuah8mSY77vANGr
         W8T2/Ed/h33sUqUIxdMc878cD+JkZ1TTOEQmMz5AmDXiM4pS5DRY+BFB2ZCIhZO5tOr7
         wfF8J9nzG96KZVBCF4vliAJlQv7Udjw4RXAQ789O1/BYJzQbjk51dSx4u6ZkGTYsxWvn
         kWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RPbQDiX/Zy5K2QrYqqrxGkL0efikkW2IcEvpnZvUnM=;
        b=GrCVM5vAoRARwRa+h9lBhYQWupsQWwZH5bJ8t8ucix0nSYSbsa8TA/hOUKS21X+v9o
         tH2Hjb/aUJs/9Q9pafks5LT5neWE1UnoqtPJtrIVvCtVyCOEZ7xejBW4a1xsJOkqqVts
         lRt5tEEw0BMHYYoXqJ1TFpqoEwiLQkJZ8xOcMVeKYkAOQgw7ZvKyO7/2oRTa//YpjkYg
         tB6oMEpAKx0UAeIWbXdQT4ITVfVHVIifo+3WtMkeIkaFzzmStb23djlIlcJbMvp6ryXx
         NvIlPpsoZl+0Ey8bMW3kX+dW8ZMvvTJFo6W5q0weVnbJWxtTBpt4JeZ1LYN0TLV+TeVE
         4P/w==
X-Gm-Message-State: ANoB5pkeYfR3H5ErrAzXm2pPBaqS9C22W6no8wsBhhWqLUphekkvZdA8
        11Dt/MsNEbXiq3k1dUHIP5Y=
X-Google-Smtp-Source: AA0mqf5Xxray6D3+mXRLHWF58GvQ7m6HjKU0FFsHL5zPClvSguTfCmLGVG2CAcNgb6Pupq2yit0Ieg==
X-Received: by 2002:a17:903:26c7:b0:188:4f86:e4ea with SMTP id jg7-20020a17090326c700b001884f86e4eamr7773858plb.59.1668778479580;
        Fri, 18 Nov 2022 05:34:39 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b00186b1bfbe79sm3757677plg.66.2022.11.18.05.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:34:38 -0800 (PST)
Message-ID: <ed4dac84-1b12-5c58-e4de-93ab9ac67c09@gmail.com>
Date:   Fri, 18 Nov 2022 22:34:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_XSKMAP
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     mtahhan@redhat.com, bpf@vger.kernel.org, donhunte@redhat.com,
        jbrouer@redhat.com, linux-doc@vger.kernel.org,
        magnus.karlsson@gmail.com, thoiland@redhat.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221117154446.3684330-1-mtahhan@redhat.com>
 <8d4899f1-fcd2-edc6-31da-363b13f8049b@gmail.com> <m24juwy5cu.fsf@gmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <m24juwy5cu.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Donald,

On Fri, 18 Nov 2022 09:33:21 +0000, Donald Hunter wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
>>
>> So you have two declarations of bpf_map_lookup_elem() in map_xskmap.rst.
>>
>> This will cause "make htmldocs" with Sphinx >=3.1 to emit a warning of:
>>
>> /linux/Documentation/bpf/map_xskmap.rst:100: WARNING: Duplicate C declaration, also defined at map_xskmap:71.
>> Declaration is '.. c:function:: int bpf_map_lookup_elem(int fd, const void *key, void *value)'.
>>
>> , in addition to a bunch of similar warnings observed at bpf-next:
>>
>> /linux/Documentation/bpf/map_cpumap.rst:50: WARNING: Duplicate C declaration, also defined at map_array:43.
>> Declaration is '.. c:function:: int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);'.
>> /linux/Documentation/bpf/map_cpumap.rst:72: WARNING: Duplicate C declaration, also defined at map_array:35.
>> Declaration is '.. c:function:: int bpf_map_lookup_elem(int fd, const void *key, void *value);'.
>> /linux/Documentation/bpf/map_hash.rst:37: WARNING: Duplicate C declaration, also defined at map_array:43.
>> Declaration is '.. c:function:: long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)'.
>> ... [bunch of similar warnings]
> 
> That's unfortunate, and I'm responsible for some of those. Not sure how
> we'd know to check for warnings with Sphinx >= 3.1 when
> Documentation/doc-guide/sphinx.rst and
> Documentation/sphinx/requirements.txt both specify version 2.4.4

Sorry, I didn't mean to blame anyone. :-/

I think I need to share some background.
Please read on.

> 
>> You might want to say you don't care, but they would annoy those
>> who do test "make htmldocs".
>>
>> So let me explain why sphinx complains.
>>
>> C domain declarations in kernel documentation are for kernel APIs.
>> By default, c:function declarations belong to the top-level namespace,
>> which is intended for kernel APIs.
>>
>> IIUC, most APIs described in map*.rst files don't belong to kernel.
>> So I think the way to go is to use the c:namespace directive.
>>
>> See: https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#namespacing
>>
>> As mentioned there, namespacing works with Sphinx >=3.1.
>> Currently, kernel documentation build scripts support only the
>> "c:namespace" directive, which means you can't switch namespaces in the
>> middle of a .rst file. This limitation comes from the fact that Sphinx
>> 1.7.9 is still in the list for htmldocs at the moment and build scripts
>> emulate namespacing for Sphinx <3.1 in a limited way.
> 
> What's the reason for keeping support for Sphinx 1.7.9 and pinning to
> 2.4.4 in Documentation/sphinx/requirements.txt if we want to support
> Sphinx >= 3.1? Given that the latest Sphinx release is 5.3.0, and Python
> 2 support was dropped in Sphinx 2.0.0 it seems that we need to have a
> higher minimum version and a higher default version.

Middle term, progressing to recent versions of Sphinx is highly hoped
as we'd really like to utilize the namespacing capability in its full
strength.

Unfortunately, as is mentioned in ./scripts/sphinx_pre:

   Please note that Sphinx >= 3.0 will currently produce false-positive
   warning when the same name is used for more than one type (functions,
   structs, enums,...). This is known Sphinx bug. For more details, see:
	https://github.com/sphinx-doc/sphinx/pull/8313
 
, later Sphinx emits a dozen of false positive warnings of duplicates.
Hence we stick to Sphinx 2.4.4 in doc-guide documents. 2.4.4 or 1.7.9
is good enough for catching easy-to-fix errors in .rst files.

See https://lore.kernel.org/linux-doc/20220702122311.358c0219@sal.lan/
for Mauro's thoughts on these issues.

What I'm doing now is manually distinguishing false and real positives
and asking fixes of the latter, so that transition to later Sphinx
versions would be smooth as possible. On of such fixes is commit
c18c20f16219 ("mm, slab: remove duplicate kernel-doc comment for
ksize()") which landed v6.1-rc5.

> 
>> So please avoid putting function declarations of the same name in
>> a .rst file.
> 
> The same function name, with different signature gets used as a BPF
> helper and as a userspace function. We'd really like to be able to
> document the semantics of both for a given BPF map type, all on the same
> page.
> 
> Is there a better way for us to highlight the function signature,
> without using the c:function:: directive, since they're not really
> function declarations?
If you don't feel like bothering with namespacing, your option would
be to use the code-block directive.
I see a couple of APIs presented as plain literal blocks in
map_cgrp_storage.rst.

If you change them to "code-block"s as follows:

diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/map_cgrp_storage.rst
index 5d3f603efffa..be31f250453b 100644
--- a/Documentation/bpf/map_cgrp_storage.rst
+++ b/Documentation/bpf/map_cgrp_storage.rst
@@ -18,14 +18,18 @@ Usage
 =====
 
 The map key must be ``sizeof(int)`` representing a cgroup fd.
-To access the storage in a program, use ``bpf_cgrp_storage_get``::
+To access the storage in a program, use ``bpf_cgrp_storage_get``:
+
+.. code-block:: c
 
     void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
 
 ``flags`` could be 0 or ``BPF_LOCAL_STORAGE_GET_F_CREATE`` which indicates that
 a new local storage will be created if one does not exist.
 
-The local storage can be removed with ``bpf_cgrp_storage_delete``::
+The local storage can be removed with ``bpf_cgrp_storage_delete``:
+
+.. code-block:: c
 
     long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgroup)
 
------------
, you can get highlighted signatures. I'm not sure if you like the
way they are highlighted, though.

Hope this helps.

Please feel free to ask if you have further questions.

Akira

> 
>> The other duplicate warnings shown above can be silenced by the
>> change attached below. It is only as a suggestion and I'm not putting
>> a S-o-b tag.
>>
>> Hope this helps,
>>
>> Akira
