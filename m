Return-Path: <bpf+bounces-42276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A274C9A1BB7
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 09:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32567289742
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790221D097F;
	Thu, 17 Oct 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/lp22Wk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B21CCB44
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150160; cv=none; b=IWre8XhWNvsriExj12v96Zrfzv/xsRCuxG+KHflAaBgKQjrry3vBawFSsmQKnOSobHJZK2TnKw5Rb4yFZZJlPGHA8Qke8GKkXAVDN6wVx5Bsf1SvNqgCsxap3owtH3ZPEDoaWNHB6c1yeCfaLNJnbTGd+szZm8qiX14+uc7Q0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150160; c=relaxed/simple;
	bh=QwwUvTO+SCQ6fA0tqntyzYvYD2Z4wF+Ww5QI1rxDaM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elXyIioyHxoXJA9CRURDkcbReRShb+hMnVWRN6oi+KovEE2UApRcMAuNVg/M6rJnu2gjnWSswwpvuuJKx11bUS5tA04imUiPxOB0shlz3KEAYL8GjMQ8JULk08WOaOvIUJ5dh8ygB0XBAIy90w+/x9PzKsuQ73eZTNfg8Byyidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/lp22Wk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729150156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kd/pG0EV/UF1DKSS0E9NWQBbNHFPgJHKBI2/QRP3KNg=;
	b=L/lp22WkifSTvZRJ0raZS11SaSyLmg6BVqcvgNDvBjYIvbBvSoBMs67N0KlCDBVqWuKY9C
	ANwqkVbKx6a1bbuc905M3Ei7vEV/jlQmq/GfarlDbJ1IQQbr2D8YWsPe95zJ2ylL4ear+H
	JeFZqNCNKdujET2jY7Z6SEG1d14oaYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-Iv2g-4YlPOOS_UhijR01jg-1; Thu, 17 Oct 2024 03:29:15 -0400
X-MC-Unique: Iv2g-4YlPOOS_UhijR01jg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d462b64e3so192692f8f.3
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 00:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150154; x=1729754954;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kd/pG0EV/UF1DKSS0E9NWQBbNHFPgJHKBI2/QRP3KNg=;
        b=jamGax5OSrIfNx/DIhel1Ry9rIGG+LwfPztLqfzQTY14DViTMX9a/70/gKUWNZSuAM
         1I92R0EixBqCcjKo+FiaByh0P4N317xtRbxDaezmCxF/ivLmd9NMBVajo+k04uiC8YJN
         hq9tDPNK3SvO02opHG9CjKgfEUK8XUVAUi1dZ4YiwaS/NnndTozXONU+L/7Ysp2VlhUR
         gE4Qs7nH0PxPQmgJBbKPgrXRbUgNdfN69k3qTuA79tzeOcwHG2csu/ht9YcYY/6TCY6K
         1VUBzyLVcFHx1e61Rb4in2pOxiu8X04XQmcAHdVHXEyfCMzOC61tW759xB27dmRDaibj
         G3bg==
X-Forwarded-Encrypted: i=1; AJvYcCUm7Q0k5Hgm5Ronslv4L+/Jt0c/jmi4nJ73FPW0cPh8IK0JSZGNDIUjwdtkLnk4kNqIjVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15a3J/DXcknFECoHiEFaRpMvkaPFmew91QrNfHDn7rctx1hlP
	GjOToawjjZEbxLc/4zjsSB5qfSUzNc8WfNAS8xeTdpgF5Z944gp0JAydWjTkFguWRUViGqyFPOQ
	VSixKaYkM2NBXcTC4Kor50gvC1yqu75+qmiR6p790E2ujFscs
X-Received: by 2002:adf:ce86:0:b0:37d:3a25:15de with SMTP id ffacd0b85a97d-37d5ffa6147mr10380178f8f.55.1729150153744;
        Thu, 17 Oct 2024 00:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCElEP5M5IJi0LbhXLcpNKOkk7QrcadkFjMrqp5F6ImRq9uLBw72iO49pXkF3aCSsjJO3H8A==
X-Received: by 2002:adf:ce86:0:b0:37d:3a25:15de with SMTP id ffacd0b85a97d-37d5ffa6147mr10380161f8f.55.1729150153420;
        Thu, 17 Oct 2024 00:29:13 -0700 (PDT)
Received: from [10.43.17.54] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7f89233fsm6447159f8f.0.2024.10.17.00.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 00:29:12 -0700 (PDT)
Message-ID: <b0b80eda-c0be-4631-bc73-849918c903c5@redhat.com>
Date: Thu, 17 Oct 2024 09:29:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Allow building with extra
 flags
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1728975031.git.vmalik@redhat.com>
 <ea7b96907258a47e071028b8d9ca21eca7ab9050.1728975031.git.vmalik@redhat.com>
 <7919c04f566896f293f6f6b3cc988bb6b5a5c95a.camel@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <7919c04f566896f293f6f6b3cc988bb6b5a5c95a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 01:17, Eduard Zingerman wrote:
> On Tue, 2024-10-15 at 08:54 +0200, Viktor Malik wrote:
> 
> Tried this, seems to work as expected, but see below.
> 
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> @@ -388,8 +394,8 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
>>  	   $(APIDIR)/linux/bpf.h					       \
>>  	   | $(BUILD_DIR)/libbpf
>>  	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
>> -		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
>> -		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)'			       \
>> +		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
>> +		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'	       \
>>  		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>>  
>>  ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
> 
> Note, that there is also the following code just below this hunk:
> 
> ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
> $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
> 		$(APIDIR)/linux/bpf.h					       \
> 		| $(HOST_BUILD_DIR)/libbpf
> 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
> 		    EXTRA_CFLAGS='-g $(OPT_FLAGS)' ARCH= CROSS_COMPILE=	       \
>                     ^^^^^^^^^^^^
>                     needs an update?

Yes, good catch, I'll add it.

Thanks!

>                     
> 		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/			       \
> 		    CC="$(HOSTCC)" LD="$(HOSTLD)"			       \
> 		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
> endif
> 
> 


