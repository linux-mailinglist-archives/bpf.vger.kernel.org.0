Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5632596EA
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgIAQIY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 12:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731352AbgIAQIL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Sep 2020 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598976489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6Pe1l+WjDC61EvtD//HCF/32BPYoKA6W4R0Ar3Xm+o=;
        b=M13etXxTrzakPaHSjxbZegVzHpnGfamjibpj04lrTfDkrEsnxkwJMBNds4UhjxWV3++Gb0
        5Lx0s56ZO6SsBKLnC11UWm+2KJ5gffnCG2y1qGwHuuRsk+WyvEFb8N4xrKH4X2Dm3hOnnT
        DktrcPocoTkG8kltDtCRq3/MFZKRwf0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-weaW9X54NvqIzLFfFBObFg-1; Tue, 01 Sep 2020 12:08:08 -0400
X-MC-Unique: weaW9X54NvqIzLFfFBObFg-1
Received: by mail-ej1-f72.google.com with SMTP id by23so725110ejb.14
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 09:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Y6Pe1l+WjDC61EvtD//HCF/32BPYoKA6W4R0Ar3Xm+o=;
        b=g0wmIrDIgQVcGz+YwDISagn5O6/P4Kxci6KgR7AeLhQWDV6r9f12RO7SabLhJ1vpkc
         Ww1L/jmxd+yidLwtVsnkG5ixcZjQv7na8qxQhl1O0uj8ufQ1PmPIHsZtg+Rwh46NP3Kk
         EC/A/ywO1XvwtwThkjtmtT9+7MNtOiWgtZCbWIae4Fi86gaGim7k29mjXOPhzShyKdtF
         0RKD9ThwmgmFZKk8oldk2ZHCFToaGLhwLJq0lu/7oZKWmnD9uYotGi3UZOyKAkSsH2L0
         MvOoPZ9RvL847bnJcE5cktU2u8AOSIT31ueziAqHLGC6OhijubI7RRkaRgl1ewSUhbNF
         zloA==
X-Gm-Message-State: AOAM5325QCUlFTS9E4iuNpIwKKTbUK/5bDXbzzYjvSz9b8P1FE8LVBSR
        E5Jg4YBKulGH2RzQSnup9HsK3ZyTbhx+M+UtoDge8rq7I5Yge2kUpjBR764nNDBcw9Wqq7Ds7N7
        l3jnfG4qEDqC+
X-Received: by 2002:a17:906:2858:: with SMTP id s24mr1943703ejc.399.1598976486611;
        Tue, 01 Sep 2020 09:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf4rJNDRun8zwi8xW7tBsqxccI0tzxxEHy5tlb4nz2mpp2kS6TKqmRoxAArSsBUNsyYYQWkw==
X-Received: by 2002:a17:906:2858:: with SMTP id s24mr1943676ejc.399.1598976486356;
        Tue, 01 Sep 2020 09:08:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g26sm1458131edv.70.2020.09.01.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 09:08:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 30D691804A2; Tue,  1 Sep 2020 18:08:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH bpf] tools/bpf: build: make sure resolve_btfids cleans
 up after itself
In-Reply-To: <20200901152048.GA470123@krava>
References: <20200901144343.179552-1-toke@redhat.com>
 <20200901152048.GA470123@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Sep 2020 18:08:04 +0200
Message-ID: <87sgc1iior.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:

> On Tue, Sep 01, 2020 at 04:43:43PM +0200, Toke H=C3=83=C2=B8iland-J=C3=83=
=C2=B8rgensen wrote:
>> The new resolve_btfids tool did not clean up the feature detection folder
>> on 'make clean', and also was not called properly from the clean rule in
>> tools/make/ folder on its 'make clean'. This lead to stale objects being
>> left around, which could cause feature detection to fail on subsequent
>> builds.
>>=20
>> Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in=
 ELF object")
>> Signed-off-by: Toke H=C3=83=C2=B8iland-J=C3=83=C2=B8rgensen <toke@redhat=
.com>
>> ---
>>  tools/bpf/Makefile                | 4 ++--
>>  tools/bpf/resolve_btfids/Makefile | 1 +
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
>> index 0a6d09a3e91f..39bb322707b4 100644
>> --- a/tools/bpf/Makefile
>> +++ b/tools/bpf/Makefile
>> @@ -38,7 +38,7 @@ FEATURE_TESTS =3D libbfd disassembler-four-args
>>  FEATURE_DISPLAY =3D libbfd disassembler-four-args
>>=20=20
>>  check_feat :=3D 1
>> -NON_CHECK_FEAT_TARGETS :=3D clean bpftool_clean runqslower_clean
>> +NON_CHECK_FEAT_TARGETS :=3D clean bpftool_clean runqslower_clean resolv=
e_btfids_clean
>>  ifdef MAKECMDGOALS
>>  ifeq ($(filter-out $(NON_CHECK_FEAT_TARGETS),$(MAKECMDGOALS)),)
>>    check_feat :=3D 0
>> @@ -89,7 +89,7 @@ $(OUTPUT)bpf_exp.lex.c: $(OUTPUT)bpf_exp.yacc.c
>>  $(OUTPUT)bpf_exp.yacc.o: $(OUTPUT)bpf_exp.yacc.c
>>  $(OUTPUT)bpf_exp.lex.o: $(OUTPUT)bpf_exp.lex.c
>>=20=20
>> -clean: bpftool_clean runqslower_clean
>> +clean: bpftool_clean runqslower_clean resolve_btfids_clean
>>  	$(call QUIET_CLEAN, bpf-progs)
>>  	$(Q)$(RM) -r -- $(OUTPUT)*.o $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg \
>>  	       $(OUTPUT)bpf_asm $(OUTPUT)bpf_exp.yacc.* $(OUTPUT)bpf_exp.lex.*
>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfid=
s/Makefile
>> index a88cd4426398..fe8eb537688b 100644
>> --- a/tools/bpf/resolve_btfids/Makefile
>> +++ b/tools/bpf/resolve_btfids/Makefile
>> @@ -80,6 +80,7 @@ libbpf-clean:
>>  clean: libsubcmd-clean libbpf-clean fixdep-clean
>>  	$(call msg,CLEAN,$(BINARY))
>>  	$(Q)$(RM) -f $(BINARY); \
>> +	$(RM) -rf $(if $(OUTPUT),$(OUTPUT),.)/feature; \
>
> I forgot this one.. thanks for fixing this

You're welcome - it was a bit frustrating to track down, but a simple
fix once I figured out what was going on.

BTW, there's still an issue that a 'make clean' in the toplevel kernel
dir will not clean up this feature dir, so if someone doesn't know to do
'cd tools/bpf && make clean' the main build may still break (I happened
upon this because my main kernel build broke :/). Couldn't figure out
how to convince make to fix that, so if you could take a look that would
be great! :)

-Toke

