Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C12449A3
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfFMR0k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 13:26:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38921 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfFMR0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 13:26:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so23462775qta.6
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2019 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=pSobfuX80DioF2GpT3MRccbEnhouAD+zp19ZY9QABnQ=;
        b=xeuCKAQ9BfUjHBNa+MzpfJLBBKd4xJFFF1dVjDAGPYuHQ23o4DcV8HXGTuhVP7hrFc
         ywNwL450TVGnZbueqVtlXDF6l0jgEjbf+mmb/nJZRnMii2Lq6uKW5NZE46bhnmCI9ADY
         lli/42WwFTHm6RCyeD0RbTWW3dZk8xUCM+h2N7owWJJIP+2f3OPaqORhz2FkLuxPFrBD
         mJYkCUIJfxwJfbCS0w1krNP9tmgtGR2e06OtzhLVnNIT7L6d7KFrSc8JPJwLZZqnDGjz
         csXzUamGBIMUllkZiPm07wYbme/78wdWHhlg2eocnc/2PShggz8raq6FpLOzr1p0Qtjj
         cWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pSobfuX80DioF2GpT3MRccbEnhouAD+zp19ZY9QABnQ=;
        b=WV80fZ4DgezkKa//ARylylkMFLMnq3izVH3//YhZFjHyHuUz36F7tAQw29RrRTwi2/
         9CWu2zJdRB6hdxIQVw7c+HEXLQK0gUt4C/d6txplSnrGM3tJjLb3h+qWMxhPq/umGWZD
         upMspwgXQPcG8EvHcH/oUQFSWae8rivJzAjYyqaT9RLR4ieV1618/NXwx1nchhN4JuPF
         Z1l+6NxUJA0kh0MVzOTqTdUUwH4zZyGG1nkrSCtTVXiJgPCUCZPIVRRFNGNyT3YVfKMS
         o+Ap8HBuLx31aXbJcguEmaHiIT75wT3KqJyKExOtxpFoI82CRYpJVwfMea0EambdE9M5
         zA9w==
X-Gm-Message-State: APjAAAW/71T8ASYmjKdTDNJMjuW/8tc4xRW5Pu50hsn1xw4a7RhBInbN
        fFku2QN5F2PiEZd3VS8wGosMlA==
X-Google-Smtp-Source: APXvYqxMw1EiNfQi2FXM2lkCqhTGECsMfmOuSBcXBYGG+/ZJssCiswtAeJiVovl8F5hpEL/9qdbwaA==
X-Received: by 2002:ac8:1829:: with SMTP id q38mr58457960qtj.252.1560446799708;
        Thu, 13 Jun 2019 10:26:39 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r5sm110881qkc.42.2019.06.13.10.26.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 10:26:39 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:26:34 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Maxim Mikityanskiy <maximmi@mellanox.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?Qmo=?= =?UTF-8?B?w7ZybiBUw7ZwZWw=?= 
        <bjorn.topel@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] net: Don't uninstall an XDP program when none
 is installed
Message-ID: <20190613102634.18fdb910@cakuba.netronome.com>
In-Reply-To: <CAJ+HfNg8C+teCywDDjKY6_gdPsg_dzm1cMNFhj7gLps6RYMAJQ@mail.gmail.com>
References: <20190612161405.24064-1-maximmi@mellanox.com>
        <20190612141506.7900e952@cakuba.netronome.com>
        <CAJ+HfNg8C+teCywDDjKY6_gdPsg_dzm1cMNFhj7gLps6RYMAJQ@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 13 Jun 2019 11:04:45 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > > +     } else {
> > > +             if (!__dev_xdp_query(dev, bpf_op, query))
> > > +                     return 0; =20
> >
> > This will mask the error if program is installed with different flags.
> > =20
>=20
> Hmm, probably missing something, but I fail to see how the error is
> being masked? This is to catch the NULL-to-NULL case early.

You're right, it shouldn't matter.
