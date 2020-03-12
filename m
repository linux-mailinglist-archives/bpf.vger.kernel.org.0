Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B030182F89
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 12:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLLrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 07:47:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55169 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLLrI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 07:47:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so5743908wmc.4
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xcb1whEx/M7l8V4RY5VY7erWSpV6ZvtwmpcEaLu64g0=;
        b=maKSHf6Q4gWs6xZTm9GF/adE/CXeZL92JER0q0FwvuQUQRGfyBGTzpyCk0GYdVh1M9
         6ihCBWG421zER0obAv0QsrM93VmVgtIRAID4LMxx5Xxcc6i5kGkkwUOBqCS1mmHGW4tN
         pjD1OwhJMUF3cxMtbFi5/IukCI//+o8MueQseOYE/ouDWt8rcBF7QMVJyu4pB/VtanJv
         UDEW80aoBPQbWjtNph5MiBcOI5Dd8U4RZcq06XF/CYkOPNPkJz+Bvi6gqPB3pAqYYKc1
         b65NsHXFJIcBVMa+koxkI7LMAiSEbSKnlTZwf0eUBigs+OXbf+n7P7tiLlLyZdAyo9sq
         0NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xcb1whEx/M7l8V4RY5VY7erWSpV6ZvtwmpcEaLu64g0=;
        b=imtCnQKjlXqZHbEypKppBp1/deINKWa1vBJXy5b58gqKLhPkocchpSm+utxqiAT3jJ
         s2i41BZY+PJPUh6+sRbjjEUoevuDk0Ckxv4nO+bcf6K0cnT2VbFhVxm6zYgPLoLgVN3u
         xkynrk1lVwEYi2ZPxPrjD6WyX3KcQfXakbYSP9OSpeWGmsuAmJBaotitlavYyrmegfFW
         qwBuoLkrQOoF6Ac5qBU1aLm2VDIFSrNcnvhHAt9wo//ZUsglpkkHUSP4DR2QqzPtoI7N
         i/pkGQC4mSYYNvgnvfoNWTODTqGoUB2wJRBKtYiQbgRoJ9XByOYVc7tj/CCo9pXBzTr/
         RAPA==
X-Gm-Message-State: ANhLgQ2R2vfvpP2q+i2Qti+Wjt3CDoMFFZN2TVqL8W2F5LJZL+zjPVG0
        Edz66aS2MorQOWXR4U/ybfXL1w==
X-Google-Smtp-Source: ADFU+vugDeW0GjkoY8ZMLo2RqQcsW8eatBEEiR9uf5turd+5k6XRbw8qTPAq4F+YYjT3ABU5bG4eDg==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr4668964wmf.50.1584013625332;
        Thu, 12 Mar 2020 04:47:05 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id f17sm67015171wrj.28.2020.03.12.04.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:47:04 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 3/3] bpftool: add _bpftool and profiler.skel.h
 to .gitignore
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     john.fastabend@gmail.com, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, arnaldo.melo@gmail.com, jolsa@kernel.org
References: <20200311221844.3089820-1-songliubraving@fb.com>
 <20200311221844.3089820-4-songliubraving@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <d3172674-c1b9-0be9-5d2a-6259db647aad@isovalent.com>
Date:   Thu, 12 Mar 2020 11:47:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311221844.3089820-4-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-11 15:18 UTC-0700 ~ Song Liu <songliubraving@fb.com>
> These files are generated, so ignore them.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
