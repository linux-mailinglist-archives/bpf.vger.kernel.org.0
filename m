Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C568F48A
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjBHRaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjBHR3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:29:54 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE6EFB6
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 09:29:51 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id q13so3215806qtx.2
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 09:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nmFd2VKY/+BOvbFyIWwEHa9R+4ZfHR8qYWF6LEj0Ig=;
        b=aS00afFO9J5KhkTwgkid5hu581LD6UKR4De54zyJNDAz57eUEl8Qf8j7G0ddj4dhlE
         1rXJmqcaD19hYqQs7Jiy1VpZp+DzAex1FUiOXH846w84+CYbmSdWpIc6AVhPe0TN9MZC
         AGzrdsVzFXzrQHcXOC7EO+crRT4VqN/gvYkP88BCdXjmus41ARWvGpL1ghfN01DNH+zM
         BNm5sa+tSeIKQVl/M/oje9l2yrEZeiArfz6kdk7/BeGyZ6SzxYkBRlJtoSnB0ae8xp6R
         /Z4r/XQcWruB1bh5Nm4kYJpCBmloeyNuCYpYp7ZeVGSTabUYXekW7O6pcYv0SjMGugIV
         6f0w==
X-Gm-Message-State: AO0yUKUpYkC/eg9E+dqnspY9PaNnwMqWqbt+SxbvAvJ0/i7dovzazNja
        t9PmmEIU4uCinmgZlH7HXeZ7IbcmOPgO3mZy
X-Google-Smtp-Source: AK7set+CxQ3+77zq/JceWOcNAG9wUydNC5J7x4ZYYhGzpIIqTDEan9qr38wB+6nfOsrN1nCTEne3pQ==
X-Received: by 2002:a05:622a:118d:b0:3b8:2ce4:3e9 with SMTP id m13-20020a05622a118d00b003b82ce403e9mr14675282qtk.32.1675877390409;
        Wed, 08 Feb 2023 09:29:50 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8e05])
        by smtp.gmail.com with ESMTPSA id d19-20020ac847d3000000b003b6325dfc4esm11674537qtr.67.2023.02.08.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:29:49 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:29:55 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Message-ID: <Y+PcE1O/uPdAWxYF@maniforge.lan>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
 <Y+O7b5iKBUpskWLg@maniforge.lan>
 <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 05:26:34PM +0000, Dave Thaler wrote:
> David Vernet wrote:
> > > +Reserved instructions
> > > +====================
> > 
> > small nit: Missing a =
> 
> Ack.
> 
> > > +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
> > instruction if ``-O0`` is used.
> > 
> > Are we calling this out here to say that BPF_CALL in clang -O0 builds is not
> > supported? That would seem to be the case given that we say that BPF_CALL
> > | BPF_X | BPF_JMP in reserved and not permitted in instruction-set.rst. 
> 
> Yes, exactly.  I could update the language to add something like
> "... so BPF_CALL in clang -O0 builds is not supported".

Gotcha, that sounds good to me. Thanks for being so thorough in
documenting all of this tribal knowledge.
