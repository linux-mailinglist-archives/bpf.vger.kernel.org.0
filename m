Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED262EBFB
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 03:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiKRCgj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 21:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRCgi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 21:36:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18918D49F;
        Thu, 17 Nov 2022 18:36:36 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 6so3816750pgm.6;
        Thu, 17 Nov 2022 18:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB/GwExgNQFI4Rk5S1Ov/sIbs2yJsQ6ddZM05Pq44Rk=;
        b=dOc4qm7qTsJ6uxiWcyTY1AYOt/HFK3HOSq1hsivQkxsbbG2VYoV51em0kqRu2nCJOx
         JqV8M9s80qB58lfSNAdCBfA9WH9HG3GY0oHiNextaye5KjPZV/lI6kCefVMDi2Dv1U2o
         xj9xOmevOxwv+Js0rcNcHVKBVTmUXAfGew1X0nkQq3lxte6O+AcZc+xnmqlNMUDGq5u2
         p2pBVo043x8+A7YKNoIGDKcjwKiRL7mLiRQ/OGPC32BFqV4QsMvi85NJ8r18EW29sbEm
         nPQMqAjJ1tGYkMmFLN6V5b2xYQem0kiuhTgDsPx+hm8xO/MKArynYetjyhARKkjj1xig
         NiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB/GwExgNQFI4Rk5S1Ov/sIbs2yJsQ6ddZM05Pq44Rk=;
        b=PcMqgFfgtDFk0LutiLoieU9KRaT0yKPfRGaT6e7j1OGTS0YzRfbAy36o9/6qQs23Bo
         200O/XIm7vA9xS91M0a3CLagEOIBWMZhY9UI3jkkWudRRfEfoOo6BFtg1YRzRLcwVwKX
         GXKB3a6OK4/iMZ5W2SYBd92+4frWSLc1WdvVHv6koghY3U1Jroo7aoYpeD9Dv7ZS8gUn
         v1bq7H1fiALH+8assG7W26MoBxvztJDRb7MG8x9T29jthYwCB4P8xLsGyMBWuQeidb3l
         0cfC9Mw7+bTRCVY8u3r9tOVAyEPNRMM4pSGSB/BHqP52D2fOMuo1zr1MnSc8MQu4i6Dk
         casQ==
X-Gm-Message-State: ANoB5pl4QFJgt/+p8oC5LmnbV950q7iHQVUG1/4JPBlOFokpjwe5qlbQ
        1eJ7wn7kJyV20TIYSyLlzFRO6sHQGS8=
X-Google-Smtp-Source: AA0mqf7EwIjpEiEJ1XlegIUShbtyy74CMtLPqZ0EzTk8jD4TAeOZ0a09HLIIQikRCOY5mejL3hEHqg==
X-Received: by 2002:a05:6a00:1d83:b0:56d:c342:ea5e with SMTP id z3-20020a056a001d8300b0056dc342ea5emr5667371pfw.71.1668738996085;
        Thu, 17 Nov 2022 18:36:36 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709029a4400b0018853dd8832sm2190409plv.4.2022.11.17.18.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 18:36:35 -0800 (PST)
Message-ID: <8d4899f1-fcd2-edc6-31da-363b13f8049b@gmail.com>
Date:   Fri, 18 Nov 2022 11:36:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, donhunte@redhat.com, jbrouer@redhat.com,
        linux-doc@vger.kernel.org, magnus.karlsson@gmail.com,
        thoiland@redhat.com, Akira Yokosawa <akiyks@gmail.com>
References: <20221117154446.3684330-1-mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_XSKMAP
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221117154446.3684330-1-mtahhan@redhat.com>
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

Hi Maryam,

On Thu, 17 Nov 2022 10:44:46 -0500, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_XSKMAP
> including kernel version introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> 
> ---
> v2:
> - Fixed typos + incorrect return type references.
> - Adjusted examples to use __u32 and fixed references to key_size.
> - Changed `AF_XDP socket` references to XSK.
> - Added note re map key and value size.
> ---
>  Documentation/bpf/map_xskmap.rst | 167 +++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/bpf/map_xskmap.rst
> 
> diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
> new file mode 100644
[...]
> +Kernel BPF
> +----------
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> + Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> + For ``BPF_MAP_TYPE_XSKMAP`` this map contains references to XSK FDs
> + for sockets attached to a netdev's queues.
> +
> + .. note::
> +    If the map is empty at an index, the packet is dropped. This means that it is
> +    necessary to have an XDP program loaded with at least one XSK in the
> +    XSKMAP to be able to get any traffic to user space through the socket.
> +
> +.. c:function::
> +    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> + XSK entry references of type ``struct xdp_sock *`` can be retrieved using the
> + ``bpf_map_lookup_elem()`` helper.
> +
> +Userspace
> +---------
> +.. note::
> +    XSK entries can only be updated/deleted from user space and not from
> +    an eBPF program. Trying to call these functions from a kernel eBPF program will
> +    result in the program failing to load and a verifier warning.
> +
> +.. c:function::
> +	int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
> +
> + XSK entries can be added or updated using the ``bpf_map_update_elem()``
> + helper. The ``key`` parameter is equal to the queue_id of the queue the XSK
> + is attaching to. And the ``value`` parameter is the FD value of that socket.
> +
> + Under the hood, the XSKMAP update function uses the XSK FD value to retrieve the
> + associated ``struct xdp_sock`` instance.
> +
> + The flags argument can be one of the following:
> +
> +  - BPF_ANY: Create a new element or update an existing element.
> +  - BPF_NOEXIST: Create a new element only if it did not exist.
> +  - BPF_EXIST: Update an existing element.
> +
> +.. c:function::
> +    int bpf_map_lookup_elem(int fd, const void *key, void *value)
> +
So you have two declarations of bpf_map_lookup_elem() in map_xskmap.rst.

This will cause "make htmldocs" with Sphinx >=3.1 to emit a warning of:

/linux/Documentation/bpf/map_xskmap.rst:100: WARNING: Duplicate C declaration, also defined at map_xskmap:71.
Declaration is '.. c:function:: int bpf_map_lookup_elem(int fd, const void *key, void *value)'.

, in addition to a bunch of similar warnings observed at bpf-next:

/linux/Documentation/bpf/map_cpumap.rst:50: WARNING: Duplicate C declaration, also defined at map_array:43.
Declaration is '.. c:function:: int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);'.
/linux/Documentation/bpf/map_cpumap.rst:72: WARNING: Duplicate C declaration, also defined at map_array:35.
Declaration is '.. c:function:: int bpf_map_lookup_elem(int fd, const void *key, void *value);'.
/linux/Documentation/bpf/map_hash.rst:37: WARNING: Duplicate C declaration, also defined at map_array:43.
Declaration is '.. c:function:: long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)'.
... [bunch of similar warnings]


You might want to say you don't care, but they would annoy those
who do test "make htmldocs".

So let me explain why sphinx complains.

C domain declarations in kernel documentation are for kernel APIs.
By default, c:function declarations belong to the top-level namespace,
which is intended for kernel APIs.

IIUC, most APIs described in map*.rst files don't belong to kernel.
So I think the way to go is to use the c:namespace directive.

See: https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#namespacing

As mentioned there, namespacing works with Sphinx >=3.1.
Currently, kernel documentation build scripts support only the
"c:namespace" directive, which means you can't switch namespaces in the
middle of a .rst file. This limitation comes from the fact that Sphinx
1.7.9 is still in the list for htmldocs at the moment and build scripts
emulate namespacing for Sphinx <3.1 in a limited way.

So please avoid putting function declarations of the same name in
a .rst file.

The other duplicate warnings shown above can be silenced by the
change attached below. It is only as a suggestion and I'm not putting
a S-o-b tag.

Hope this helps,

Akira

--------
diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
index 97bb80333254..68545702ca78 100644
--- a/Documentation/bpf/map_array.rst
+++ b/Documentation/bpf/map_array.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
 
+.. c:namespace:: BPF.MAP_ARRAY
+
 ================================================
 BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
 ================================================
diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
index 61a797a86342..25e05d14ec82 100644
--- a/Documentation/bpf/map_cpumap.rst
+++ b/Documentation/bpf/map_cpumap.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
 
+.. c:namespace:: BPF.MAP_CPUMAP
+
 ===================
 BPF_MAP_TYPE_CPUMAP
 ===================
diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index e85120878b27..3ac93ccf2b0e 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
 
+.. c:namespace:: BPF.MAP_HASH
+
 ===============================================
 BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
 ===============================================
diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
index 31be1aa7ba2c..c934c3e2bcb7 100644
--- a/Documentation/bpf/map_lpm_trie.rst
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
 
+.. c:namespace:: BPF.MAP_LPM_TRIE
+
 =====================
 BPF_MAP_TYPE_LPM_TRIE
 =====================
diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
index 07212b9227a9..f59cd0e3a72c 100644
--- a/Documentation/bpf/map_of_maps.rst
+++ b/Documentation/bpf/map_of_maps.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
 
+.. c:namespace:: BPF.MAP_OF_MAPS
+
 ========================================================
 BPF_MAP_TYPE_ARRAY_OF_MAPS and BPF_MAP_TYPE_HASH_OF_MAPS
 ========================================================
diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
index f20e31a647b9..abc8ed569900 100644
--- a/Documentation/bpf/map_queue_stack.rst
+++ b/Documentation/bpf/map_queue_stack.rst
@@ -1,6 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
 
+.. c:namespace:: BPF.MAP_QUEUE_STACK
+
 =========================================
 BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK
 =========================================
-- 
