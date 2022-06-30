Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3A561748
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiF3KH6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiF3KHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 06:07:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592E43EFA
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 03:07:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k7so2023721wrc.12
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VOByUv49LEkfwx3vW8btAzpMGPNvoDblmnx7m+ecNPg=;
        b=D4vaBrDmUJkEWmyjeXDGiuifN6KbN8nWuNLIXdY9MGHePY0NmIxEVyhp9oLKPz4WfZ
         vXfcicNQ/BoXqaS5bMJP6+SYBRCR7/Z+1tSBm8f8ADn2rwlw5MVW5tqfADDPwVsuyaG6
         bluoQoDSn0UzmTsYGk/jKxuWZnDIbe+48V6ssaHhSdpuLd44onkM84/u2F2n85/I7/4z
         4UwUsLeCN1kEfxd713PRprwdslwt/RnyAAqwKfvED++WWdvDmS17UAZr1A2rR1k9Zu7Q
         6j/ROen6XuHFZtHO23JcUP1OodTn/RSFJhheU2G39Iyt63/cp8id+0zN8upOPUvNsnxg
         BBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VOByUv49LEkfwx3vW8btAzpMGPNvoDblmnx7m+ecNPg=;
        b=JmtMHphpqQKobmZdCEGm5X91hD146llubhY9fnISoJL4MoSOy2H8wlG4CvmBJmjfr+
         iIrZY2GD5Hi3CXR282sZMv2oMtPUzyfa1byoeg1+BoFteorOEs1I/ueHjQjQQhpITSfc
         N/DHBx/w6m1WgnXOLGuoc8f+sszqqXnOo1KDbOZ8S4xYBYdG+bVII7Rlh+PnREtGHcMg
         e0I05+rY39oEfRkY/W/0aHLCGe4ox5j9bBBFFCtXdHEr3Q+UO7VuU2EgkQu+gH/WTFyi
         Jl4TvvlsXXfrc0qjjFGsq6/Y+WZwMoS7hyslRk45CqnDgEyLPH11rmP1qW6W25pU95Qo
         SVTg==
X-Gm-Message-State: AJIora+oZti3AEY4Wv2YTMPEOtsSs6jdlyqk222MD6sGcHcoljTIbAAt
        8HGHwRZPvXLb3jzfSMoZx7mZhWqLf3CJdA0C2RA=
X-Google-Smtp-Source: AGRyM1tJ45Mp3OgsaSsM/AMNXxGnmmeq+ekZ+rw9dUqiZjEWZMZXb2MCuXHrfz4cS+Cldkwqj9SKqQ==
X-Received: by 2002:adf:ce8f:0:b0:21b:b56a:fa24 with SMTP id r15-20020adfce8f000000b0021bb56afa24mr7426923wrn.173.1656583658755;
        Thu, 30 Jun 2022 03:07:38 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b00213ba3384aesm19493716wrr.35.2022.06.30.03.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:07:38 -0700 (PDT)
Message-ID: <2d937726-9d7a-51af-f348-289a7f50e344@isovalent.com>
Date:   Thu, 30 Jun 2022 11:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH bpf-next] bpftool: remove attach_type_name forward
 declaration
Content-Language: en-GB
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     bpf@vger.kernel.org
References: <20220630093638.25916-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220630093638.25916-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30/06/2022 10:36, Tobias Klauser wrote:
> The attach_type_name definition was removed in commit 1ba5ad36e00f
> ("bpftool: Use libbpf_bpf_attach_type_str"). Remove its forward
> declaration in main.h as well.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/main.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 589cb76b227a..5e5060c2ac04 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -63,8 +63,6 @@ static inline void *u64_to_ptr(__u64 ptr)
>  #define HELP_SPEC_LINK							\
>  	"LINK := { id LINK_ID | pinned FILE }"
>  
> -extern const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE];
> -
>  /* keep in sync with the definition in skeleton/pid_iter.bpf.c */
>  enum bpf_obj_type {
>  	BPF_OBJ_UNKNOWN,

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
