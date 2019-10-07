Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1ACE87E
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2019 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfJGP6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Oct 2019 11:58:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42602 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGP6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 11:58:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so8919416pff.9
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Q7rtzjnFJDzgl/cFLK/ImgYohSqUsKxMtww2iZ3LFxI=;
        b=L2UEzrQNyW4qR/63zw8zkgy4pyfPvUqJc191PUYuwqqFBzcRgHsTNjOtcz6sShZIPb
         dA/SN5iqkK380QeTr1TMQyMEyXWItFVoOPj0BTJNHvHvuYLm8lwTdbOSUuFCTyIH59hE
         pzW6qE93mQZcysE7SxfrOnzobpeM0RpPQZ9ky1GwjbHD6Kd1PNsjg2bdQ46qNOywYScA
         hRSrZvH5pu1GKgAXwZ2wpS+5O5gmxXTtnvm6JIiCE+/vjMomuawzyr7sRW5LQh9nYmYF
         2X+6u2WLm9hpqjydnIc+4dnn/LIoudKifm2BFrmEQJ8LHa46ej0iFH/IjS8BvBCylDv5
         4zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Q7rtzjnFJDzgl/cFLK/ImgYohSqUsKxMtww2iZ3LFxI=;
        b=kZD4rLBiO4fLr6d9ZDWvTd277WEYouv7SASPkQrcynSiWO7zGzOMUSHLeG6a2Yat6h
         uUoihe56S7ii2Dq3M0HokK+Oe+NF2c9tMxH0eeCZ8HvesjxlQTXxZwEW2zpnT5Udase+
         ZUY6gP56TJymiMXrXtOuxn6vEPvlfna7bWo6aJH4I4xtlth3cLzqwxdyQ+skjf/XO+V8
         bBxHaPILh9eFXmKjE/6g5YROCMEIoYgtn7FL5IjzSIt1f45twIMpdqh3MQHc2e6tp3jL
         oo/vxsDU+1c0x3rkYEjKqyssVbp0W80xAYdxiw+tdQFRNipuRJh6EhzFQf/36cW+kmx7
         bABA==
X-Gm-Message-State: APjAAAWNcndtwxwINl6sc50umEPkucLBjbkq1fwRGvgyeCclUBz777pS
        mQJ4GD1A+V+MG7sp44e3yWxE6A==
X-Google-Smtp-Source: APXvYqyhi32l/kmuUlMffnp2RlvNzUjYV7K3wiMTR7LXwgMxFjOP7LmfHSTRyJu+7lqWRtUm/ypu7w==
X-Received: by 2002:a63:f915:: with SMTP id h21mr31135096pgi.269.1570463914153;
        Mon, 07 Oct 2019 08:58:34 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y2sm17266224pfe.126.2019.10.07.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:58:33 -0700 (PDT)
Date:   Mon, 7 Oct 2019 08:58:24 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: bpf: make array exp_mask static, makes object
 smaller
Message-ID: <20191007085824.64c89788@cakuba.netronome.com>
In-Reply-To: <20191007115239.1742-1-colin.king@canonical.com>
References: <20191007115239.1742-1-colin.king@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  7 Oct 2019 12:52:39 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array exp_mask on the stack but instead make it
> static. Makes the object code smaller by 224 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   77832	   2290	      0	  80122	  138fa	ethernet/netronome/nfp/bpf/jit.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   77544	   2354	      0	  79898	  1381a	ethernet/netronome/nfp/bpf/jit.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
