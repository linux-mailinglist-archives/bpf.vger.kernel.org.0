Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2F186A6B
	for <lists+bpf@lfdr.de>; Mon, 16 Mar 2020 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgCPLyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 07:54:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47095 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgCPLyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Mar 2020 07:54:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so4405752wrv.13
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b4wbERxNv8RZWLFLe13UCpyoSyj0S8X+u+4q/v40Rao=;
        b=fGSsapZhSNwYH4H5qMgUNzkReSBlyKeQy7QZndUMt9iVMe+/ekJsbvo/xps7YBU65j
         kPShadYM3GDvyEtUUwwLePmwn/edx3A+9B27Wl9Zkm+K+WeKIabwFMdjiTdN6wSBsOBg
         2czWUMAOwbqI9+KY9eyG5GKAQ8n5oJRM7YQalha4vHRjZdnadVPfbuRjAvs8yN/JhrLF
         l4hJYT+a5Qg79ljDCs05SUP+yKhgI0k4DnMZ4Vpe4HgJDDODC8PaoO2lckcLDEMv6SFM
         nihu7Gbt6LeoVDnbFSgsLH85hq7G+OgJ4OV7Z1DDLDH6KRCvWw4DJduVXLjAW3pMmn1V
         IRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4wbERxNv8RZWLFLe13UCpyoSyj0S8X+u+4q/v40Rao=;
        b=uFP/vIcbZA4deWK31hQfMVIhf6hO5lF+kDB9BBX6I4B4l+4tf3aXflj404y4gFXAwP
         jaYZZae/NWgKadCQEhl1tmdZ8Kh9eRVtGb9+0NIsF3Uq4NAK0/Btci9oOaCwbqov5LAV
         JsXr6okJfBxTo7lym4hOazotcBoJxoVTS1He8D/TigVUcPQhWOLaqosnY6AF2PSnMWYF
         BPODOrpJ9Nkq/EScNX3v7VWuZJsypttutv49X9udWsPfIbTAKLB/zO9lGzs77oP3H4xX
         uykQ+aPLXCD4K+66aQ2oI4KVgoOjzwlhi0jIMw/tSzgCTTwPoXuh4keM591b+LRJ5j4a
         VRXA==
X-Gm-Message-State: ANhLgQ1kqMd13LuZAnQPooCCkxZjosF3eqBz89ttNqquJhPHkbe1hgUh
        H4c3Gj/m4GX3K80AsOkGEGPQbA==
X-Google-Smtp-Source: ADFU+vtENKPA5sUNNPaz/3cz91ETbHr7oBefgC5vVgGRGS7XuNZAx1sHK5imk7Km4ngH9y+FuheCLA==
X-Received: by 2002:a5d:474c:: with SMTP id o12mr18400158wrs.156.1584359683265;
        Mon, 16 Mar 2020 04:54:43 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.24])
        by smtp.gmail.com with ESMTPSA id n10sm3438630wro.14.2020.03.16.04.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 04:54:42 -0700 (PDT)
Subject: Re: [PATCH bpf-next 0/4] bpftool: Add struct_ops support
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        netdev@vger.kernel.org
References: <20200316005559.2952646-1-kafai@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <5db1351a-f197-f792-04ef-231811edef53@isovalent.com>
Date:   Mon, 16 Mar 2020 11:54:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316005559.2952646-1-kafai@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-15 17:55 UTC-0700 ~ Martin KaFai Lau <kafai@fb.com>
> This set adds "struct_ops" support to bpftool.
> 
> The first two patches improve the btf_dumper in bpftool.
> Patch 1: print the enum's name (if it is found) instead of the
>          enum's value.
> Patch 2: print a char[] as a string if all characters are printable.
> 
> "struct_ops" stores the prog_id in a func ptr.
> Instead of printing a prog_id,
> patch 3 adds an option to btf_dumper to allow a func ptr's value
> to be printed with the full func_proto info and the prog_name.
> 
> Patch 4 implements the "struct_ops" bpftool command.

Hi Martin, I have a few very small nits on patch 4 -- please see related
message -- but other than this your series looks good to me.

Acked-by: Quentin Monnet <quentin@isovalent.com>

(I did not test it, though.)

Thanks,
Quentin
