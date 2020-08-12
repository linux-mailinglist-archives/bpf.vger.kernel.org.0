Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426A242E47
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHLRuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHLRuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 13:50:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574CCC061383;
        Wed, 12 Aug 2020 10:50:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 988AD221;
        Wed, 12 Aug 2020 17:50:12 +0000 (UTC)
Date:   Wed, 12 Aug 2020 11:50:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 3/4] bpf: add eBPF IO filter documentation
Message-ID: <20200812115011.337c0099@lwn.net>
In-Reply-To: <20200812163305.545447-4-leah.rumancik@gmail.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
        <20200812163305.545447-4-leah.rumancik@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 Aug 2020 16:33:04 +0000
Leah Rumancik <leah.rumancik@gmail.com> wrote:

Thanks for documenting this stuff, but...

> +======================
> +IO Filtering with eBPF
> +======================
> +
> +Bio requests can be filtered with the eBPF IO filter program type (BPF_PROG_TYPE_IO_FILTER). To use this program type, the kernel must be compiled with CONFIG_BPF_IO_FILTER.
> +
> +Attachment
> +==========
> +
> +IO filter programs can be attached to disks using the  BPF_BIO_SUBMIT attach type. Up to 64 filter programs can be attached to a single disk. References to the attached programs are stored in the gendisk struct as a bpf_prog_array.

Please wrap your text to a reasonable column width just like with any
other kernel file.

Thanks,

jon
