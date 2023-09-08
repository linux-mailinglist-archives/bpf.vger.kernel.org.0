Return-Path: <bpf+bounces-9485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA01798695
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1561C20BD1
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F645226;
	Fri,  8 Sep 2023 11:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D634C95
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 11:47:50 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F719BC
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 04:47:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so2674503a12.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694173666; x=1694778466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VHhi8IMrZarrM/u22h55GFBcFXVfkPwvuG0llyyHBQ=;
        b=nrkGVzck2LxD+ZeYWTi2JdQqbXbplds2mmmMKTX3r/sdTENd96J2XjWECaySvWIHwS
         tqadKgEQsNRNRTtMRaD8o3kkzuQjQssrMacSasrgDGd2CsKHXNvoQ2UwQBtxbqCVWrmj
         m5O7RI0bU5QXcqtBPVxDxgkKpvKAg5bP4NWca/1AxBehNAau5mE5JsiKxWaaU8gs/i+1
         QN8CRC/YOSSo0TU8Xwr80jf4MH5lXDK59j1sxCmp+yoW8y5VWyCMEn2SXitifz4jX08c
         1rBNwlw4SdURm/rvlkKDiS8WVEXym8jwgeluYFM9rEIdVga2dxNBhFQeXOiXdRj0PYSF
         NAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694173666; x=1694778466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VHhi8IMrZarrM/u22h55GFBcFXVfkPwvuG0llyyHBQ=;
        b=PINGDATtxmo9LsyHV84ktoFVM3VO6TgvTkmWPaIpJtVcan53UvXvCvLtN2pa64TVoQ
         UW+kV92/B6eoyr3FkiFEBixFWeCmnCTd0psOWaas4N5HbjRwr9NchC6gEp1ho8VWNZMu
         W8xRel1GKXGO/aGNFbxsshJV8az23qWCnAkkKH/6zVr1FrTFHcsxmD0D+oi8afSWm7C8
         sgARZMYWI5XxC9IA6hazN39eADcpogZdctjFNz9P+CJabjyD2o1URNbJJk5630I0HWcd
         ec+0XAxNFeYR6qkXbxzHASwHq71hKWYdYUvtHSqC0tgFzSIlvz5WEko03R07iPGAt7j2
         U8Fg==
X-Gm-Message-State: AOJu0YwP+P6noU2Lc6D+VOZhCxm6+HAm3ceqXjLCdvsuOVlgTd/yunD8
	K3lRsMXtbwTNq4+YbkgKXj4=
X-Google-Smtp-Source: AGHT+IGMuQPSdSbVf9Ce26vo+FRU8shtKu/MxTncqfS+a86gEMBFPBGWTNddjF81trqAu9UNvDJAzw==
X-Received: by 2002:a50:ed06:0:b0:51a:3159:53c7 with SMTP id j6-20020a50ed06000000b0051a315953c7mr1796725eds.30.1694173666578;
        Fri, 08 Sep 2023 04:47:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t11-20020aa7d70b000000b0052e901cef48sm936374edq.48.2023.09.08.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 04:47:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 8 Sep 2023 13:47:44 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZPsJ4AAqNMchvms/@krava>
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPozfCEF9SV2ADQ5@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 10:33:00PM +0200, Jiri Olsa wrote:
> On Thu, Sep 07, 2023 at 12:01:18PM -0700, Nick Desaulniers wrote:
> > So we've got a curious report recently:
> > https://github.com/ClangBuiltLinux/linux/issues/1913
> > 
> > ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > '__BTF_ID__struct__cgroup__624' is already defined
> > __BTF_ID__struct__cgroup__624:
> > ^
> > 
> > It's been hard to pin down a SHA and .config to reproduce this, but
> > looking at the definition of BTF_ID's usage of __ID's usage of
> > __COUNTER__, and the two statements:
> > 
> > kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
> > kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)
> > 
> > Is it possible that __COUNTER__ could evaluate to the same value
> > across 2 different translation units, leading to a name collision like
> > the above?
> 
> hum, that probably the case, I see same counter values at different
> __BTF_ID_ symbols:
> 
> ffffffff833fe540 r __BTF_ID__struct__bpf_bloom_filter__380
> ffffffff833fe548 r __BTF_ID__struct__bpf_queue_stack__380
> ffffffff833fe578 r __BTF_ID__struct__cgroup__380
> 
> perhaps we were just lucky not to hit that :-\
> 
> > 
> > looking at another usage of BTF_ID other than struct
> > cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_release)
> > is only defined in one translation unit
> > 
> > Should one of those two `BTF_ID(struct, cgroup)` be removed? Is there
> > some other way we can avoid these collisions in the future?
> 
> need to find some way to make the symbol unique, will check

the change below uses object's path as the __BTF_ID_.. symbol suffix to make
it unique

I'm still looking, but can't think of a better way so far, perhaps somebody
will have better idea

jirka


---
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a3462a9b8e18..564953f9cbc7 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -49,7 +49,7 @@ word							\
 	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), BTF_ID_BASE)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..2ef8b2798be0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -200,6 +200,10 @@ _c_flags += $(if $(patsubst n%,, \
 	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
 
+ifeq ($(CONFIG_DEBUG_INFO_BTF),y)
+_c_flags += -DBTF_ID_BASE=$(subst =,,$(shell echo -n $(modfile) | base32 -w0))
+endif
+
 # $(srctree)/$(src) for including checkin headers from generated source files
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)

