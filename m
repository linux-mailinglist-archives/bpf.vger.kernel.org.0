Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535A568132C
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbjA3O2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjA3O2c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:28:32 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B5442CA;
        Mon, 30 Jan 2023 06:27:03 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id z5so514347qtn.8;
        Mon, 30 Jan 2023 06:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI0OWYWxDuCCMVlTXbTdUmFISDd8LaAEgR9Nv/pUMPc=;
        b=Y+GyUC3fnLKWYmPKVmHCk14mFFFx7Netaam4sDSauAhHddKZru/QLv1WgUupnYvSJh
         Ldxvun4n2qhdmcrj7KZSGUaRxBDW6iDaD0cUxjj/W+oDwf4rFGkM9SHXA/tZHUObd2yc
         RTo9DsiyeLggZsV8ShX7pDE7eQBO3yhUk3MK0ifPlxMXDnNTWzTYC0WlcqL1fxsskmav
         W18W0CPR5uevCbKLBk3X+dAvzmyp+jqYxZH/NnkpX+8+HeX0PlJtYC7zcyfKZGHzXyVF
         jh9NQ6bAl1PdYHcn+Wy6ing+4dawuZlhgjDyrJSldAHEEJJIg+/HblZPnmpa7jeZAPHx
         W3wg==
X-Gm-Message-State: AO0yUKVmMpvUK3eB+bLj/5nAeiPwZo5/1un6G49xoRa5Mp1HT/R0XVIM
        VXXO31kpmr916W4EoY0EK7LYt7cJMf2HVA==
X-Google-Smtp-Source: AK7set/gU41NfMbANQQ7hbaIkgmqEAoMoPJ2eb5mD1rAPBAW8yDYPDKGnRv9ptOcedvkyTGplFeDJg==
X-Received: by 2002:ac8:5ccf:0:b0:3b8:6aaf:acfe with SMTP id s15-20020ac85ccf000000b003b86aafacfemr4622485qta.38.1675088822640;
        Mon, 30 Jan 2023 06:27:02 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id a19-20020ac844b3000000b003b63d181cd3sm8071543qto.70.2023.01.30.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:27:02 -0800 (PST)
Date:   Mon, 30 Jan 2023 08:26:59 -0600
From:   David Vernet <void@manifault.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/35] Documentation: bpf: correct spelling
Message-ID: <Y9fTs88hb84+TFLn@maniforge>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-5-rdunlap@infradead.org>
 <Y9fTJLNVc5i2/XV5@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9fTJLNVc5i2/XV5@maniforge>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 08:24:36AM -0600, David Vernet wrote:
> On Thu, Jan 26, 2023 at 10:39:34PM -0800, Randy Dunlap wrote:
> > Correct spelling problems for Documentation/bpf/ as reported
> > by codespell.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: bpf@vger.kernel.org
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > ---
> >  Documentation/bpf/libbpf/libbpf_naming_convention.rst |    6 +++---
> >  Documentation/bpf/map_xskmap.rst                      |    2 +-
> >  Documentation/bpf/ringbuf.rst                         |    4 ++--
> >  Documentation/bpf/verifier.rst                        |    2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff -- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst

[...]

Ah, please disregard, I missed that Alexei had already merged this.
Thanks for the cleanup.
