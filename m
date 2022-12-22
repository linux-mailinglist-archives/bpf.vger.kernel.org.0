Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5B654310
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLVObI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 09:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiLVObG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 09:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8272A263
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671719415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yo59GqjO245jjbdybBDkZsJXQxnZlKsA5iXDQYeufjY=;
        b=YZ+bHPq/YOo7qxSL9wadozo+2anZtAkFay/9kYPbpEHUpKyrBGW1GVDfTOaGeMYO+z6zy1
        JzBvG5dA5cjd321dWElnlHwL0tfJj4GiU1oyhqVhHejJjK8ndloOqhtT99zDHbOxKyH4Jp
        z2zQK457Hq/55T1QRpgtSbN0k4kfXYE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-sajXSBFlMwKDfVYr4PRibg-1; Thu, 22 Dec 2022 09:30:14 -0500
X-MC-Unique: sajXSBFlMwKDfVYr4PRibg-1
Received: by mail-qk1-f198.google.com with SMTP id br6-20020a05620a460600b007021e1a5c48so1293510qkb.6
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 06:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo59GqjO245jjbdybBDkZsJXQxnZlKsA5iXDQYeufjY=;
        b=DmTXq/gt0Ob3X3tb0mSo3kSRL2ryjGJcx4M3LTklL7MSSbFvimYvTKBuwu/UyBlMSH
         9a/t544HkvaDkDD6PSdaabHJSBNyaRvppWCsK4Acl0aKS2kX3h56RJ3w8cJxATTCZgBN
         s6MHTwIpEx3c1hDFn60DJyEHpcHaKz4EArt2LLEZBF3lv7H4NW/zybWCPgiX/GvAZI/L
         lr5kQ69gRZS6Qs9Zd/FaZwjOUKZDh22aFkmn3MHfzFlWW2aLgpfP62owR05yeOR9PhBz
         7Tnr/3C6v0pQBePZJ8E6ZPOeuKQ72JM6LV52KlNm7CrLGBrf0QYCE0mBshBVh8T/Kh9Q
         vTYg==
X-Gm-Message-State: AFqh2krkPdUajs9FPHbw8pOeica2XI6B34xTeLl7nDcDkmiDPcZBKhq3
        oMyVrq3jqiZAhCU1Zc7uxDX3kD0tF75/8DLop8bnpThgjX+c5ACOJ8IvfkhI9msjT8PptXOSmnz
        2d/VAv4whFYFA
X-Received: by 2002:ad4:4a0d:0:b0:4c7:595c:9940 with SMTP id m13-20020ad44a0d000000b004c7595c9940mr6960722qvz.51.1671719414000;
        Thu, 22 Dec 2022 06:30:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvPyViPBixvVZNakCJM3/xzQlf8XOkmUa8FdRqwh6A4H0LYpabXnVu13PwfDTm3dHMOSlzzHA==
X-Received: by 2002:ad4:4a0d:0:b0:4c7:595c:9940 with SMTP id m13-20020ad44a0d000000b004c7595c9940mr6960699qvz.51.1671719413783;
        Thu, 22 Dec 2022 06:30:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a430900b006fba44843a5sm389389qko.52.2022.12.22.06.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:30:13 -0800 (PST)
Message-ID: <81f4b4347be5fa9c0b7a87905e979183aed35acf.camel@redhat.com>
Subject: Re: [PATCH] veth: Fix race with AF_XDP exposing old or
 uninitialized descriptors
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Shawn Bohrer <sbohrer@cloudflare.com>
Cc:     magnus.karlsson@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, bjorn@kernel.org, kernel-team@cloudflare.com,
        davem@davemloft.net
Date:   Thu, 22 Dec 2022 15:30:09 +0100
In-Reply-To: <20221221170700.32e5ddc6@kernel.org>
References: <Y5pO+XL54ZlzZ7Qe@sbohrer-cf-dell>
         <20221220185903.1105011-1-sbohrer@cloudflare.com>
         <20221221170700.32e5ddc6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-12-21 at 17:07 -0800, Jakub Kicinski wrote:
> On Tue, 20 Dec 2022 12:59:03 -0600 Shawn Bohrer wrote:
> >  	if (stats.xdp_tx > 0)
> >  		veth_xdp_flush(rq, &bq);
> 
> This one does not need similar treatment, right?
> Only thing I could spot is potential races in updating stats, 
> but that seems like a larger issue with veth xdp.

Agreed, I think stats would deserve a separate patch (and this one
looks correct).

Cheers,

Paolo

