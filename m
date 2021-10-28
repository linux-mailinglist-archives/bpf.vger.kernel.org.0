Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6E43DA0D
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 06:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhJ1EDi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 00:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1EDi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 00:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635393671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDm1iBdNqWeiGldmOuAg2u1RcKbFKQ7rouatH/IZldQ=;
        b=FhXNobGNsr1itLsh7U5gxm+h4BotV2jOabH1Xxxgb4xjkhQ+La8Dr9SG+h+rshcrgmB7Lz
        mfLEH2+XBt4N2RQsFvuCMZKsIQC6xmgTnA22Q9odOCcWwLgniBX8v7jbl81k58cytLqwni
        uwq+cKCYbxoSyibz2mlrz41/mGSrgUU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-VLkfqHK7PYinTVN6LS0m3g-1; Thu, 28 Oct 2021 00:01:09 -0400
X-MC-Unique: VLkfqHK7PYinTVN6LS0m3g-1
Received: by mail-qv1-f69.google.com with SMTP id jz13-20020a0562140e6d00b00387252642e5so2412232qvb.14
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 21:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDm1iBdNqWeiGldmOuAg2u1RcKbFKQ7rouatH/IZldQ=;
        b=bBxAxo2JeGF7Y//NBqSPhueJMxOPJXOnvoBd/AVvxKRtR2HLm9BDE0zP3+sK7kAxry
         iT3U5Lh7vM6sF/V3tjke02L5iaPAaxk7SaU3zx6xi1VF3FAuSrB/fOcbzBvcwZmMSQ25
         MgUmjs2p/2DXgVwwnMa585xdsJAmkaKkvFCM4Z0yLagtSvSOCbkKWeZp0M/S6J3RClSI
         F2j85abtmT+yIGEl9JBf4B3hA0EKi1vDzekdIat5oZe9wbACKgW/0pNjf1F64tZaB5ua
         CYbhym7AL/2ggThsubaMd889eZ1pUlrdGh/wieMpkdQVWzRISxnaX8Bl7aMFH2v0mw/9
         4ksw==
X-Gm-Message-State: AOAM5314yzYajbnnrq20xd9++wqNBYJjZ1eTrkGU8z8KpAaeb6kQTclb
        qRNoLynZpNZVeYRwOnKYPGd5ZmmVIIZiA4mX3cAlzwZuAb7oVgWldkFcVv3Ab3MVrmTxRs+4k8r
        aZO19GCuezLsn
X-Received: by 2002:a05:620a:c50:: with SMTP id u16mr1514883qki.203.1635393668801;
        Wed, 27 Oct 2021 21:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1UKpXmWUaI/dfdJ7+9cjZb8DUgTGQZUOjor4OWYIFNwC8ahO8kPwB7HDPsyxVXMMjtKAE6w==
X-Received: by 2002:a05:620a:c50:: with SMTP id u16mr1514861qki.203.1635393668618;
        Wed, 27 Oct 2021 21:01:08 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bp9sm1275967qkb.94.2021.10.27.21.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:01:08 -0700 (PDT)
Date:   Wed, 27 Oct 2021 21:01:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 02/16] objtool: Explicitly avoid self modifying code
 in .altinstr_replacement
Message-ID: <20211028040105.evz2inkbb7647ytr@treble>
References: <20211026120132.613201817@infradead.org>
 <20211026120309.722511775@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120309.722511775@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:34PM +0200, Peter Zijlstra wrote:
> +	/*
> +	 * Alternative replacement code is just template code which is
> +	 * sometimes copied to the original instruction, For now, don't

s/,/./

> +	 * annotate it. (In the future we might consider annotating the
> +	 * original instruction if/when it ever makes sense to do so.).

s/\.$//

> +	 */

-- 
Josh

