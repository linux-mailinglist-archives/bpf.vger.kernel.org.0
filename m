Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C975B3C61
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIIPwE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIIPwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:52:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBBF02A8
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:52:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so3176772edd.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fGlsklyl2lYDi+41yqVj5NPxvBqq+WE6PvQHldu8I6M=;
        b=MKexWdCf+W8u19r7eKKWVm7KNzHydFPUJWiEdQMSRUrbzcrg+y5+slKLTqcsITCEC5
         /ses84HXgHqg3bhX56RoYKOGQlCuLlfQblxV0prCMx6a3sYuL031q6WkPdj022NVJNPv
         aJ+cpUe8RX8bM30k4BOsMYwhKJuP08QmUh7mqvUcaAII3uEamyFIDzbS0iJ5xiupRQA1
         /+YRPRtQ2drLOq8V9CnpFqHm6tvpR97ulQgxkXxhkpA2QkdCXor3b0HAT8vME+wWQFrT
         YzSA5o00Zc1pmbwH3EiZWMi+dGaFSskeFEU07efw3ix+L4fVhsekO1gUtJffvJNALo3a
         dBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fGlsklyl2lYDi+41yqVj5NPxvBqq+WE6PvQHldu8I6M=;
        b=sD8dDSPN2mcyFRwyb09cgBxBmoReGCF0WXnUZvySm4UXLYF1aFCy7v01ecuL5/XqTT
         mHNsAev5ybFzg6gaEr1ymTH7z+YwLccn8iX7VfM2X7OeX3KLBlFucqi/4r4Rk2JDhwtk
         FyN1PevXAefOH0JpJFjbDBXCEH9/UAqdOAPNECkfMvVtW1OmAxTgRsjzLmIkhczM84Z+
         KAdDduITOxKRjR1O61XF8lndDdn6CkEjQZJwBnN3qpq6l2i8ECJ1M433TTvkb4cqnie0
         kB3r/Of0PF3fsezlu+wSbhE6poh/IWj5BgRiaLsHGPmHTdgxrPqFs1WRI2W4hwWxM9b9
         uLoA==
X-Gm-Message-State: ACgBeo2d7ksB4x4vJM6LAPJKG1n32lPPig4LAuW/gGvaiWwAIgSZP5qo
        HN8h4X03DYv9FccZYS8dDfg=
X-Google-Smtp-Source: AA6agR5ziz4oEQB1S6g/xW1yd9AKxYZze2yf8A1vpLwv5y+1X352GBkhAzfLIUjrhYPzgnXkvjXhBQ==
X-Received: by 2002:a05:6402:1e8d:b0:441:58db:b6a2 with SMTP id f13-20020a0564021e8d00b0044158dbb6a2mr11685663edf.277.1662738720176;
        Fri, 09 Sep 2022 08:52:00 -0700 (PDT)
Received: from blondie ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b0044e8d0682b2sm545164edu.71.2022.09.09.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:51:59 -0700 (PDT)
Date:   Fri, 9 Sep 2022 18:51:56 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add bpf_dynptr_data_rdonly
Message-ID: <20220909185156.7e204814@blondie>
In-Reply-To: <20220908000254.3079129-2-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
        <20220908000254.3079129-2-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  7 Sep 2022 17:02:47 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> Add a new helper bpf_dynptr_data_rdonly
> 
> void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 len);
> 
> which gets a read-only pointer to the underlying dynptr data.
> 
> This is equivalent to bpf_dynptr_data(), except the pointer returned is
> read-only, which allows this to support both read-write and read-only
> dynptrs.
> 
> One example where this will be useful is for skb dynptrs where the
> program type only allows read-only access to packet data. This API will
> provide a way to obtain a data slice that can be used for direct reads.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
