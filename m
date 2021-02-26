Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95C325B6D
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 03:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhBZCCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 21:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZCCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 21:02:09 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0CC06174A
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 18:01:29 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e2so6756567ilu.0
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 18:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kwQLHSZIXQqAcqJEjSNrTXTgaxP4lsit1OMX0Gg3gso=;
        b=vQmfkr+8zvH681NHOblt/uKCEj1SiMJQSJ6JDvjlWqKr6Yvm9sbjc7GdsZmplr5Rx+
         sSHpPTuYg/+uAQZNzvSCQT2lhzYT7DC9d+McaST54b6gz61TuDTyWPDsGNO7De4u58zL
         ja6AeelXYcyTh7x0z5Z+0QIQ2HHPRS1J6bp+6emMG7LSaj4fwU7qD76MOcAghnw+DE9A
         tXcWNibkVTs27ZvyC4g5I1hGsrX7KyTBKOYNpWyb2tXzHjd9mR3oe2OpIZ066zxIZXgi
         hR3MueQKBwMMHYWyYo8nGcIBhIVmlTNg5hKaQe42iOMFWAVd4+7kXzGbgu1KhVjOfcqQ
         8DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kwQLHSZIXQqAcqJEjSNrTXTgaxP4lsit1OMX0Gg3gso=;
        b=OIC1/GgaXHHmSsOV/znVj6zKvtGsQX+sw/u0Xwq1jJdK4H+OJZ+WY2aX29j3vpwtDv
         caMquoYynXYti7XAl2PXDWDvBqc01ORj81Piemvfiqo6T9OiGpCWl9K4lAyMRqeYRNrv
         JZeilR+tsDr0XkazidptoXsnco8RQ+BYaKDO9q9mU3TBUzd34oYMuRqMb368oMNH2bX+
         DxInBb71jc7feaRD0ArukquYQxtFUzdtaI22IhLEpAxy5ZypqaA2HnprgBoi6WZeaMX6
         g1flvZ2917Ok0rTPMB7iJ3AC4y+LzTWtBxw+/O6o0wXBty0AVvwPlTYvwj3sBu12Dvjp
         fhhw==
X-Gm-Message-State: AOAM532Fs1oIzXJ/hB3Ac0h8jSwtwdj0wyLOraIhU41QfOB4KF9F7Xtb
        PEUrKatonxBxXzyK3z8Q35K1C/m5vLoczA==
X-Google-Smtp-Source: ABdhPJzail/Ne5UeEwVN2Dubm0ZFpkIn40mBmBZDyaa5BjYMBynKA1Ky7FSMqfu4593WN72drRmqwA==
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr523562ilk.209.1614304888917;
        Thu, 25 Feb 2021 18:01:28 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id a2sm4369093iow.43.2021.02.25.18.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 18:01:28 -0800 (PST)
Date:   Thu, 25 Feb 2021 18:01:20 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <603856707afdb_5c312088d@john-XPS-13-9370.notmuch>
In-Reply-To: <20210224234535.106970-8-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-8-iii@linux.ibm.com>
Subject: RE: [PATCH v6 bpf-next 7/9] selftest/bpf: Add BTF_KIND_FLOAT tests
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> Test the good variants as well as the potential malformed ones.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
>  tools/testing/selftests/bpf/prog_tests/btf.c | 131 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   3 +
>  3 files changed, 138 insertions(+)
> 

Should we also add a test in reloc_size.c to verify bpf_core_field_size()
is working correctly with floats. Seems like a useful test to me.

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
index d7fb6cfc7891..c75d135009ab 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
@@ -30,6 +30,7 @@ struct core_reloc_size {
        int arr_field[4];
        void *ptr_field;
        enum { VALUE = 123 } enum_field;
+       float floating;
 };
 
 SEC("raw_tracepoint/sys_enter")
@@ -45,6 +46,7 @@ int test_core_size(void *ctx)
        out->arr_elem_sz = bpf_core_field_size(in->arr_field[0]);
        out->ptr_sz = bpf_core_field_size(in->ptr_field);
        out->enum_sz = bpf_core_field_size(in->enum_field);
+       out->floating_sz = bpf_core_field_size(in->floating);
 
        return 0;
 }
