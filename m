Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59B1117D33
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 02:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLJBd5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 20:33:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41174 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLJBd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 20:33:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so6563977plb.8
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 17:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lz2jgCjhsjSBdanP5Xi6rfxGe3ZVUcopSd5AgqFMvY4=;
        b=HrrAaBvu5ZrKUApiRB3ZXOk3raRIC69TCpRgVi6MjOblvxfFCUrIBaV0x5J61dRDRy
         32ehC474dQuc0Hu0NO1apmhvsEtUo9tnKO7LOTpHsyPkEmw698RempaA/m5d/ZW2G03/
         9r/eIVZ3/Bd/uUcdtA+IaP1k/oSbLkKPupPNoJEzqMcKowShlv/TUlldLNt0jYh/s9kn
         bdwNg5BExyLyY16HPZ+fwVKxfGEsUVvt9gqVvJZjSasToZy4CZR4/Z0WqhWVZw/CZiTg
         KbowruIXyD+bVzKgBgeI13i/5F176caI1+500nhwn++FVz8XWvllQSRnPVwmPjzjiRPi
         T6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lz2jgCjhsjSBdanP5Xi6rfxGe3ZVUcopSd5AgqFMvY4=;
        b=gus2Au7chQMD4+Sn9Vlk8d3d/8YqJLdVy7yWIE5rn7BnqAcS2QqBTIaj0ciJGw+hrg
         /DEuHKtIACyc8HtHBTrxMHjxPnUW9XFw7GnOAZyQ5neAGBQrMjne7JvsoH9uBST18T7n
         m5GcFu+2zFLGOrdK+UJbMyBHRMrcgTG1hPK7iJGpbHUKeAlkC1zOAhp2hnoGejyeLoNI
         WbQCNuxVm7L2MABj4pTq1w9s9aUkqBFKfe39zn/fNeomEOd9Fs27fgOmdQOFlMZ789xi
         dbpFjQs+EyvI7zj9lzd5J6HGAwHX/VCqN/Jtew5LGSmICEixltwhPT9ifewtnkbqDTj+
         CnVw==
X-Gm-Message-State: APjAAAVxLVmVP2o0Vert0WnGbFb5C40T82ScvxtcFc/Ff9CGqMD3SPzP
        6ymPR8EZYlK2Rpyj3P4UL9HG4Q==
X-Google-Smtp-Source: APXvYqzEiwc8JmGrzzfX3cuGnpphseHbuyQPaGdwrkhTp+6snh25AimwpnNHKLybEAvi8KszEKWWHg==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr2349106pjb.125.1575941636989;
        Mon, 09 Dec 2019 17:33:56 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id j38sm779975pgj.27.2019.12.09.17.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 17:33:56 -0800 (PST)
Date:   Mon, 9 Dec 2019 17:33:53 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <andrii.nakryiko@gmail.com>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 03/15] libbpf: move non-public APIs from
 libbpf.h to libbpf_internal.h
Message-ID: <20191209173353.64aeef0a@cakuba.netronome.com>
In-Reply-To: <20191210011438.4182911-4-andriin@fb.com>
References: <20191210011438.4182911-1-andriin@fb.com>
        <20191210011438.4182911-4-andriin@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 9 Dec 2019 17:14:26 -0800, Andrii Nakryiko wrote:
> Few libbpf APIs are not public but currently exposed through libbpf.h to be
> used by bpftool. Move them to libbpf_internal.h, where intent of being
> non-stable and non-public is much more obvious.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/net.c         |  1 +
>  tools/lib/bpf/libbpf.h          | 17 -----------------
>  tools/lib/bpf/libbpf_internal.h | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 4f52d3151616..d93bee298e54 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -18,6 +18,7 @@
>  
>  #include <bpf.h>
>  #include <nlattr.h>
> +#include "libbpf_internal.h"
>  #include "main.h"
>  #include "netlink_dumper.h"

I thought this idea was unpopular when proposed?
