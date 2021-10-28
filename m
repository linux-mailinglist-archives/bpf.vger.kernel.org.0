Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4443DA08
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 05:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhJ1EBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 00:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229645AbhJ1EBB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 00:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635393514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ek5ATL1TPnzxx9rmMjyQPzlEbSmEt+54jM7SEgv68c=;
        b=LKU2Mrv4/fPomY8Sdovj9JGbEz3weyXIjA5k70s57ciYenLnv31+gfRRTQHJcm2RL7Y0m2
        2Oy9mGedQbeZvIBVOq/2nyAXnJzTMkZBIf0tbXKaB+ARxE+TakI5jwxaNExJOK5JXDq9/o
        kxeSsFOKcv8Ytp7EtZrlCuGHsRNjRRI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-ikcPovHtMi6WbClmTgnI8g-1; Wed, 27 Oct 2021 23:58:32 -0400
X-MC-Unique: ikcPovHtMi6WbClmTgnI8g-1
Received: by mail-qk1-f200.google.com with SMTP id f12-20020a05620a15ac00b0046007dbd2a7so3075677qkk.3
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 20:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ek5ATL1TPnzxx9rmMjyQPzlEbSmEt+54jM7SEgv68c=;
        b=thnMooGB+ye7NRRfHycDwGMcr7yyDYunB1E1Da+D/WRk/idh9atqICAVa0uHCDkUsE
         lEVEs3Nbm0ZKQWUSGf73ZTIxePuDF0KF33Rqee8l+kWG5kZ63RsOkSMAzA4ize0nLjYe
         tkAa4Knn4whgaL/iJS7LdFlNrJHqQhj993ntpnVaSNO8Kvlm/9CQs1TxqF87v2EYLmsT
         sIxzbVRh6GW6CsPyBuSaZj6TiczCdbqFEuAQwV95yJfEe94s4KWBvQVdY21rydG2CAfD
         gQsH1y+bixsihbYwvZq2gWtG6HSBRf1xMg1oegsTdPCOy1dYhPhZ/cOiSk5TKAEBRUAY
         q0Bg==
X-Gm-Message-State: AOAM530gAu65mgRoyiakiRrcu83a7YJADUlYUE7TyzF5ksq8t3tggumu
        U2j9k8N6UBXHy5fDWFDl1SrycAhhh9wm3Wd33+CM0eHxVk/Nh2DLF6myr9ZOE8ma9A8Ruuo5Hr0
        bUzrwbJB2NAXZ
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr1523799qkp.365.1635393512291;
        Wed, 27 Oct 2021 20:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCsW2WiKwN5RiRTVcwiWVuqcuhHx8/ryX6WcnFXnPhiWySF450O6HBu1Clr2PQoi84x5HuWQ==
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr1523784qkp.365.1635393512036;
        Wed, 27 Oct 2021 20:58:32 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o2sm1280794qtw.17.2021.10.27.20.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 20:58:31 -0700 (PDT)
Date:   Wed, 27 Oct 2021 20:58:28 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 01/16] objtool: Classify symbols
Message-ID: <20211028035828.q4opdtbarrbklczp@treble>
References: <20211026120132.613201817@infradead.org>
 <20211026120309.658539311@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120309.658539311@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:33PM +0200, Peter Zijlstra wrote:
> @@ -55,7 +55,10 @@ struct symbol {
>  	unsigned int len;
>  	struct symbol *pfunc, *cfunc, *alias;
>  	bool uaccess_safe;
> -	bool static_call_tramp;
> +	u8 static_call_tramp : 1;
> +	u8 retpoline_thunk   : 1;
> +	u8 fentry            : 1;
> +	u8 kcov              : 1;
>  	struct list_head pv_target;

Might as well convert uaccess_safe to a bitfield?

-- 
Josh

