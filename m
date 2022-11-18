Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5862F532
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 13:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiKRMmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 07:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbiKRMmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 07:42:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC71A7C039
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 04:42:05 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so12715843ejc.7
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 04:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2HvpWVTvTe2cfzAa9n7+9FlJSvAdIkioz9Az37UrHzQ=;
        b=hiOLOX8EV3Q5qZbX5vWaG31AbKFniB1CtZzU3Hk/p9bUnXfp1FnEjALkckrIpDMnXa
         HV2CgJZM84DDCAwNwid0BlVFlUK9mGNXwukIMuE32anYKlvufWsHp98e2dqJTiRynCtD
         kAwAp7ev2UF5dGlB65fGj8XVPcdjbTIh3kaGFEZ7TlsfcUWln+NGJOlCQbvrf4yAjf/s
         VZsBwvzT66LQNwPffY+idrt3ADuPLyiZoBiKsaG6XpdyFHLE/Pd2RCOTfeaCUDgDch8E
         3xmbpindi5igm0mAzBCCMrF0po4d0a7GVLIyL9xbUutUtyMiozu0VS0OG4P2o8QQhtCO
         MhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HvpWVTvTe2cfzAa9n7+9FlJSvAdIkioz9Az37UrHzQ=;
        b=yBZ1F94RsG2Fs9X5D/nN7JAZvD+r+QnCjubK1k1vGr5ZmW38+58RRiD4EmKqF88s62
         0dLbYEm9cC31P8liMpDIpnAF9gHP7rYYHBSZhg6m/LJcPwLMzkxJz0osv+JwvDxI79Hc
         ZKesx2tSMZhxOPOvdim7yZXm4qloZmKvThVFGogdKYoUfG+HaRqSJkUzQLC2ueJon2j6
         wGSmH0qqcaYeesvdn6hiNMh7ndPZi/I+kbCW4JZAw8mslVpGd4q/CX0S/D7zRLTpWp7H
         XLeKmXng5Yw0xVVieVgAyf3mbrnLeixUwlWg/2NFljnSRWIGuucUTYraRdXtGorwsR9v
         iSKA==
X-Gm-Message-State: ANoB5plfKS+rctSgC0Oyj3sR8pDAYPuW5mhrCbBWZF92MR4HbIwMM4hq
        ukXpqc/ikYHnNwz37wd/PlsHIuXNIL8=
X-Google-Smtp-Source: AA0mqf75ipiOS8g4Ksmca3BO+s+q2a77jae0boTwtwF5CAzKlMJ2cggnlkhvCSvFYOp9P9OED7uKnw==
X-Received: by 2002:a17:906:79d3:b0:78d:b6f7:53c0 with SMTP id m19-20020a17090679d300b0078db6f753c0mr6016089ejo.527.1668775324327;
        Fri, 18 Nov 2022 04:42:04 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f13-20020a056402004d00b004615f7495e0sm1782938edu.8.2022.11.18.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:42:03 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 18 Nov 2022 13:42:01 +0100
To:     Per =?iso-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Bad padding with bpftool btf dump .. format c
Message-ID: <Y3d9mYrkWjrkJ9q2@krava>
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 10:30:50AM +0000, Per Sundström XP wrote:
> Hi,
> 
> I don't know if this is the channel for reporting issues with the
> "bpftool dump .. format c" function.
> If this is not the one, please help me find the correct one.
> 
> This bash script illustrates a problem where 'bpftool btf dump <file>
> format c': produces an incorrect 'h' file.
> I looked into it a bit, and the problem seem to be in the
> "libbpf/btfdump.c : btf_dump_emit_bit_padding()" function.
> 
> I can dig into it more if you like, but first I want to report it as a
> bug.
> 
> Regards,
>    /Per
> 
> ---- bad_padding bash script ---
> ----------------------------------------------------
> #
> # Reproduction bash script for wrong offsets
> #
> cat >foo.h <<EOF 
> #pragma clang attribute push (__attribute__((preserve_access_index)),
> apply_to = record) 
> struct foo { 
>    struct { 
>        int  aa; 
>        char ab; 
>    } a; 
>    long   :64; 
>    int    :4; 
>    char   b; 
>    short  c; 
> }; 
> #pragma clang attribute pop 
> EOF 
> 
> cat >foo.c <<EOF 
> #include "foo.h" 
> 
> #define offsetof(TYPE, MEMBER) ((long) &((TYPE*)0)->MEMBER) 
> 
> long foo() 
> { 
>  long ret = 0; 
>  //ret += ((struct foo*)0)->a.ab; 
>  ret += ((struct foo*)0)->b; 
>  ret += ((struct foo*)0)->c; 
>  return ret; 
> } 
> EOF 
> 
> cat >main.c <<EOF 
> #include <stdio.h> 
> #include "foo.h" 
> 
> #define offsetof(TYPE, MEMBER) ((long) &((TYPE*)0)->MEMBER) 
> 
> void main(){ 
>  printf("offsetof(struct foo, c)=%ld\n", offsetof(struct foo, c)); 
> } 
> EOF 
> 
> # Vanilla header case 
> printf "============ Vanilla ==========\n" 
> cat foo.h | awk '/^struct foo/,/^}/' 
> gcc -O0 -g -I. -o main main.c; ./main 
> 
> # Proudce a custom [minimized] header 
> CFLAGS="-I. -ggdb -gdwarf -O2 -Wall -fpie -target bpf
> -D__TARGET_ARCH_x86" 
> clang $CFLAGS -DBOOTSTRAP -c foo.c -o foo.o 
> pahole --btf_encode_detached full.btf foo.o 
> bpftool gen min_core_btf full.btf custom.btf foo.o 
> bpftool btf dump file custom.btf format c > foo.h 
> 
> printf "\n============ Custom ==========\n" 
> cat foo.h | awk '/^struct foo/,/^}/' 
> gcc -O0 -g -I. -o main main.c; ./main 
> 
> printf "\n=== BTF offsets ===\n" 
> printf "full   : " 
> /usr/sbin/bpftool btf dump file full.btf | grep "'c'" 
> printf "custom : " 
> /usr/sbin/bpftool btf dump file custom.btf | grep "'c'"
> 
> #---------------------end of script -------------------------------
> 
> 
> Output of ./bad_padding.sh:
> ---
> ============ Vanilla ========== 
> struct foo { 
>    struct { 
>        int  aa; 
>        char ab; 
>    } a; 
>    long   :64; 
>    int    :4; 
>    char   b; 
>    short  c; 
> }; 
> offsetof(struct foo, c)=18 
> 
> ============ Custom ========== 
> struct foo { 
>        long: 8; 
>        long: 64; 
>        long: 64; 
>        char b; 
>        short c; 
> }; 

so I guess the issue is that the first 'long: 8' is padded to full long: 64 ?

looks like btf_dump_emit_bit_padding did not take into accout the gap on the
begining of the struct

on the other hand you generated that header file from 'min_core_btf' btf data,
which takes away all the unused fields.. it might not beeen considered as a
use case before

jirka


> offsetof(struct foo, c)=26 
> 
> === BTF offsets === 
> full   :        'c' type_id=6 bits_offset=144 
> custom :        'c' type_id=3 bits_offset=144
> 
