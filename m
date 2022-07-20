Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1ED57BDEA
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGTShF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTShF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 14:37:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB071BD3
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:37:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so24896421eda.3
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Ji/fFil6ujP1qxH5pi1RPJFkQ6nBgwXKUBFz7mrom8g=;
        b=KUhaLamY+45e4B5ceb8OG2g5NSXXNQKijwz1IIMVWT8i9B/IFMeHieLzwfxDmbItHE
         7M9pH1u4e00DpfLaSFt7Zxx6t4JJiwn5ivU6V7jYBbY8wFZScTWIBLHGbJnXyVrxaeyp
         WE1JMjLvn4UVS/sw9rWjfSAA/uK5PHd/xMqGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=Ji/fFil6ujP1qxH5pi1RPJFkQ6nBgwXKUBFz7mrom8g=;
        b=pv5ke+kVllyNG5f5CXnP4dINQNH3eVPaak8TzRtWaRgAjYZ3p1v81E6qoKpJJUMIHn
         8MR+sN/JjxObk/JQHUauX47GoQpwwu6BU47pPrV0YpMheOidYISrqy+n359boWty4xPo
         qpzmRuD4cPOhB75CmOjrUz0gBlVcUuBfeM4QXLxWrLfVHnb98+2GKnqG4YrpOMZUaDru
         RpM5cuGf1TiP6XOozXwhxboOkOj+SQb29wZ2o74e6Cpk6vKfxdkK3fMxDjoUQqGaIoEv
         rOlg0pum3zpx8O/mo1breV7yJj+tqurLqgv3efK0Ksiq6LGQFYYIzH9eYXuBpjlfCnNk
         Sbig==
X-Gm-Message-State: AJIora/yRcbZHDh7AdFrSc6VXGLjydiAq+gGPMC/b5b04DO4dKQ1YoOs
        g+BsXgM6YR2Nppuxgg14Z99QvQ==
X-Google-Smtp-Source: AGRyM1vunJDL2peNu3cepH9en+7j1QknI/4WD8pQH8nEc2YzOwDOcF2BR/jfwSC6TCMHqs8cPNCWgg==
X-Received: by 2002:aa7:c0d8:0:b0:43b:bafd:c966 with SMTP id j24-20020aa7c0d8000000b0043bbafdc966mr4057828edp.359.1658342222691;
        Wed, 20 Jul 2022 11:37:02 -0700 (PDT)
Received: from cloudflare.com (79.184.200.53.ipv4.supernova.orange.pl. [79.184.200.53])
        by smtp.gmail.com with ESMTPSA id h5-20020a0564020e0500b0043b5adf54b3sm7813843edh.61.2022.07.20.11.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:37:02 -0700 (PDT)
References: <20220616055543.3285835-1-andrii@kernel.org>
 <87lesnyeph.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next] libbpf: fix internal USDT address translation
 logic for shared libraries
Date:   Wed, 20 Jul 2022 20:32:09 +0200
In-reply-to: <87lesnyeph.fsf@cloudflare.com>
Message-ID: <87czdzy6k2.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 05:32 PM +02, Jakub Sitnicki wrote:

[...]

>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 8ad7a733a505..e08e8e34e793 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -172,13 +172,15 @@ $(OUTPUT)/%:%.c
>>  # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
>>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
>>  	$(call msg,LIB,,$@)
>> -	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS) -fPIC -shared -o $@
>> +	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)   \
>> +		     -fuse-ld=lld -Wl,-znoseparate-code -fPIC -shared -o $@
>>  
>>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
>>  	$(call msg,BINARY,,$@)
>> -	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)  \
>> -		  liburandom_read.so $(LDLIBS)	       			       \
>> -		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
>> +	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
>> +		     liburandom_read.so $(LDLIBS)			       \
>> +		     -fuse-ld=lld -Wl,-znoseparate-code	       		       \
>> +		     -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
>
> [...]
>
> Not sure if this was considered - adding a dependency on Clang for the
> target platform makes cross-compiling bpf selftests much harder than it
> was.
>
> Maybe we could use $(CLANG) only when not cross-compiling, and execute
> $(CC) like before otherwise?

OTOH, there seems to be nothing Clang specific about the build
recipe. We just want t use LLVM lld. GCC accepts -fuse-ld as well (bfd
vs lld).

Perhaps we could partially revert to something as below? It "fixes" the
cross-compilation build of bpf selftests for arm64 for me.

WDYT?

--8<--
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d59ec7f4c2d..541e2b0de27a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -170,24 +170,24 @@ $(OUTPUT)/%:%.c
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),x86)
-LLD := lld
+ALT_LD := lld
 else
-LLD := ld
+ALT_LD := bfd
 endif
 
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds
 # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
 	$(call msg,LIB,,$@)
-	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)   \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -fPIC -shared -o $@
+	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)	\
+	          -fuse-ld=$(ALT_LD) -Wl,-znoseparate-code -fPIC -shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
-		     liburandom_read.so $(LDLIBS)			       \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code		       \
-		     -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
+	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)	\
+	          liburandom_read.so $(LDLIBS)					\
+	          -fuse-ld=$(ALT_LD) -Wl,-znoseparate-code			\
+	          -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
