Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ECE6C5DDF
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 05:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjCWETG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 00:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWETF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 00:19:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D961A641
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:19:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k14-20020a056830150e00b0069f156d4ce9so6931226otp.6
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545143; x=1682137143;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bj8+phS2JlYZPR1SuxhwdAa2mcOROvNv9b58dNeeX2Q=;
        b=ANZ3Eh7XIrSC9h9MW9jiSVg/mbAIubnzWi6KW8BZzwQcS11nSrPwIyh/rpiFSvrVO3
         F9jxCkD1xJdydWZ20w62JH185JJT3bLYpOqbRxaNuJfdUyqxwyefQusGukg3CHAKRbzm
         HaFOcTmcU1cc+ayMpPSxBMF3z/76P1bmwDaJ1AlBzURfNpcluvqL3LLg24ebTu0BwJrA
         o+8jp0qX8zB8QtHcNpkgoaasKwNNi9rckIa6U7uhDPGq9m1/+myl66O4KAGqyRMhjO58
         0OwKYKaiZRjI3dgkyyL8lGTlDXohPl+2lRob0YG6Brq4kkkqQcxmKkbyYyjcKOuEI3Cg
         lhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545143; x=1682137143;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bj8+phS2JlYZPR1SuxhwdAa2mcOROvNv9b58dNeeX2Q=;
        b=n3Wfp8Xa8CU7ShYPhCNe/UlSOvxBnDdKF7kc05chorTXaZjsGB3moi0DesbacuRrI3
         Bj3WKq4yX7fT6LVAviTgtbtojBWceuN5+dRZ78uEwBaiProaRetA4ThBNNnXaHPYFzkh
         /L0/XKECsFV1x5to95QWx1qlb3vjoKjDkrnlVv+Fu4rNdF50aP0xe5fJG+xMarjbdcG5
         ukXQljy1juSHdf/H/PDilWv4ovwW1NI6y2Q+ihK6KlepJfHN2eW6HqEEKqjnaVnQVJak
         EWKtPEXx4OdLeXZTBpNUEvAvIolWfLAVWzfQkABfpRNFav2/WXj17tgLf/XmXtVmwf88
         z9bA==
X-Gm-Message-State: AO0yUKWFWh0+22sbKWhWAd0XcuZNmylkWVaqtLUa1V6t33xz2vCOj1Cg
        CdSQI6ke9Rax+Dmxpc5qn6ligIvEgKNG6PBNntvg9EV5p+7gbw==
X-Google-Smtp-Source: AK7set/9PlWbquVDp5x0FUbfJiE1vmwIezwTTV/Q+1yaTkJLstIvvVJlJu7jQjxG4kmNTN6Xsb3pr6ZY8J/Gw9sredc=
X-Received: by 2002:a05:6830:22c6:b0:69f:1679:2faa with SMTP id
 q6-20020a05683022c600b0069f16792faamr1882162otc.5.1679545142908; Wed, 22 Mar
 2023 21:19:02 -0700 (PDT)
MIME-Version: 1.0
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 22 Mar 2023 22:18:51 -0600
Message-ID: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
Subject: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm seeing this gen object error with gcc does not occur in llvm for a
bpf test(which uses both linked_maps1.c and linked_maps2.c) in
bpf-next.

I presume there is a bug in GCC which is triggering a double free bug in libbpf.

GCC gen object failure:

==2125110== Command:
/home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool
--debug gen object
/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps.linked1.o
/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps1.bpf.o
/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps2.bpf.o
==2125110==
libbpf: linker: adding object file
'/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps1.bpf.o'...
libbpf: linker: adding object file
'/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps2.bpf.o'...
Error: failed to link
'/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps2.bpf.o':
Cannot allocate memory (12)
==2125110== Invalid free() / delete / delete[] / realloc()
==2125110==    at 0x484B0C4: free (vg_replace_malloc.c:884)
==2125110==    by 0x17F8AB: bpf_linker__free (linker.c:204)
==2125110==    by 0x12833C: do_object (gen.c:1608)
==2125110==    by 0x12CDAB: cmd_select (main.c:206)
==2125110==    by 0x129B53: do_gen (gen.c:2332)
==2125110==    by 0x12CDAB: cmd_select (main.c:206)
==2125110==    by 0x12DB9E: main (main.c:539)
==2125110==  Address 0xda4b420 is 0 bytes after a block of size 0 free'd
==2125110==    at 0x484B027: free (vg_replace_malloc.c:883)
==2125110==    by 0x484D6F8: realloc (vg_replace_malloc.c:1451)
==2125110==    by 0x181FA3: extend_sec (linker.c:1117)
==2125110==    by 0x182326: linker_append_sec_data (linker.c:1201)
==2125110==    by 0x1803DC: bpf_linker__add_file (linker.c:453)
==2125110==    by 0x12829E: do_object (gen.c:1593)
==2125110==    by 0x12CDAB: cmd_select (main.c:206)
==2125110==    by 0x129B53: do_gen (gen.c:2332)
==2125110==    by 0x12CDAB: cmd_select (main.c:206)
==2125110==    by 0x12DB9E: main (main.c:539)
==2125110==  Block was alloc'd at
==2125110==    at 0x484876A: malloc (vg_replace_malloc.c:392)
==2125110==    by 0x484D6EB: realloc (vg_replace_malloc.c:1451)
==2125110==    by 0x181FA3: extend_sec (linker.c:1117)
==2125110==    by 0x182326: linker_append_sec_data (linker.c:1201)
==2125110==    by 0x1803DC: bpf_linker__add_file (linker.c:453)
==2125110==    by 0x12829E: do_object (gen.c:1593)
==2125110==    by 0x12CDAB: cmd_select (main.c:206)
==2125110==    by 0x129B53: do_gen (gen.c:2332)
==2125110==    by 0x12CDAB: cmd_select (main.c:206)
==2125110==    by 0x12DB9E: main (main.c:539)
