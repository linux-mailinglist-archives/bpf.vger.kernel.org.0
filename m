Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76005744B3
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGNFxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiGNFxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:53:10 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594A62C65B
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:53:08 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8E870240108
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 07:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657777986; bh=6eudJm1GBl6Wx/QDoQZhChO+reUzLPytn8GobX9RbCI=;
        h=Date:From:To:Cc:Subject:From;
        b=F7byWUNJz8TGJFtcRGqGsTrvo8mWI9S3PVuMmcCaP5NKsBC38FcUGqLveIqT8fDKY
         yY5LQkcEXtwfHui+j6RNzZxvULnWSiw6h+EZTqWYUDPHyJBzHda5dH41VOo5o7bIJS
         0XJ9v1CsvTUiU6P4ZW8UN5shRHRmHdWWpyQD1La7C1hivFI6xf1PpIV+w2so19FIeM
         BYVNWWzsjy3uqpL+oNkUjHnewfa52ahGKQM84JkRwpk++xwNqLPQ5zMR4UuljH0W0k
         w9Vcg4hKtlWCucT4e7JBUWRDu1axvJh4reHnfu5VnW8QNrKk+h+wdstcPAep4LTX/4
         XFVfw0rr/6/6A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lk3Yr4S5Kz9rxV;
        Thu, 14 Jul 2022 07:53:04 +0200 (CEST)
Date:   Thu, 14 Jul 2022 05:51:37 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Message-ID: <20220714055137.dsatpuyrwdlel2ck@vaio>
References: <20220713211612.84782-1-donald.hunter@gmail.com>
 <99351eee-17b4-66e0-1b9e-7f798756780a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99351eee-17b4-66e0-1b9e-7f798756780a@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 08:12:57AM +0700, Bagas Sanjaya wrote:
> On 7/14/22 04:16, Donald Hunter wrote:
> > This commit adds documentation for BPF_MAP_TYPE_HASH including kernel
> > version introduced, usage and examples. It also documents
> > BPF_MAP_TYPE_PERCPU_HASH, BPF_MAP_TYPE_LRU_HASH and
> > BPF_MAP_TYPE_LRU_PERCPU_HASH which are similar.
> > 
> 
> Please, please use imperative mood instead for patch description
> (that is, better write like "document BPF_MAP_TYPE_* types").

Can you elaborate why you make that recommendation, please?

Thanks,
Daniel
