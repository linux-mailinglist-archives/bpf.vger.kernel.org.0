Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E13601B5D
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJQVlJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 17:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJQVlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 17:41:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CD7FE5C
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 14:41:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so12170865pjf.5
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rdZsxZEg5kujYkbEyUgg0HA5bDtiecvQRDAXeljkrA=;
        b=DnQEsLkNhtWmpBOPVfvmFEJMUlFywph6hW/CXYUVsNCyjGTcu2ReOjl202h6qggh7p
         L93lj6AHpeI1LSMG/LrlJqMO37pSwhGIAQT6mQaYC91Afoeui2xqGFJvYdZ/U+g3qJqJ
         0UBTx23xkE23oD2604wWOE5aYzqNTx3qxxghXTiWWBhrVZ42ttA4LzKnEoKhOMIs86xv
         bBH8gTxIXCxGollu91+zUirNoJW3yzMIeVlCKsXWZ/p72BSNWZmwi1jv8sKboGQKVzhM
         nLbFobMBCaopAZh1gIKM5qBsrwbW78PjeG5eSgRUVHBAUXfZI01mtx/Dpbo/Ei4Bz4wv
         fVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rdZsxZEg5kujYkbEyUgg0HA5bDtiecvQRDAXeljkrA=;
        b=5ay4A2TWsavgZbkxIzYPM8kFS+FdeTy5pJ2WLPNN/rLMn/3viOE/YkS6b9ClrN945D
         GG57bqS5h1FYX4f1QRPsq4Y935H0rvVWfk8eyvTlFA91MqwsB+OEKBHy0dGkU+idnK/I
         837lL6PoAuQnJsJJl6RXuy/oBN0kNEYN2ijv3oflvJNzaSQea0D8Rcn//3gb6wzH/eRS
         xxmoJbu6KoRPL+Io+5u2ZVtzUzKVHjtCPd4zuK+NvTSJEQP6Dsmdy8lCbguOktTykqDI
         fU9KgfaCqLHDw8HN/EtDMPdBSYrvVPYlz637P3Ra8qBehrJx2fx7BRwRRa0iQhf22Pud
         yZCw==
X-Gm-Message-State: ACrzQf1OljQtyG6zf+LvHxGRWR5j4ZoFpEbtM9u3MjROaGJd0rYFH8Wz
        bDxG88NAf9DmYnONIh/C8+1oTIS2ic0=
X-Google-Smtp-Source: AMsMyM6pFhTFEmsT4KlGpEsD1wf0YWLKXWOi6D/cYBXJHf81anwPX+xaK5p5iUt4STEDbLecnaOd8Q==
X-Received: by 2002:a17:90b:1e46:b0:20a:f9d8:1ff7 with SMTP id pi6-20020a17090b1e4600b0020af9d81ff7mr36227073pjb.34.1666042867453;
        Mon, 17 Oct 2022 14:41:07 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:c8c])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b005636326fdbfsm7586920pff.78.2022.10.17.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:41:06 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:41:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Subject: Re: [PATCH 1/9] bpf, docs: Add note about type convention
Message-ID: <20221017214104.rtle5zdwnipqhwvb@macbook-pro-4.dhcp.thefacebook.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
 <DM4PR21MB3440B73030D09B1F09082807A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR21MB3440B73030D09B1F09082807A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 17, 2022 at 08:42:13PM +0000, Dave Thaler wrote:
> Just checking if there is any more feedback on this patch set,
> as I've seen no comments since this set was posted on October 4th
> which addresses comments received on the previous submission.

The was an issue found by build bot...

> Let me know if I'm missing some step I should be doing as I'm new
> to this submission process.

I'm still not excited about 'appendix'. How about moving it into separate file?
instruction-set-opcodes.rst ?

If folks really want to use it in automated way that table needs to be uniform
and shouldn't be interleaved with normal text.
That's why a separate file with just that table seems a better fit.
