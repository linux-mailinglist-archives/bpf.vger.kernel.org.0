Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8476E5BF4
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 10:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjDRIXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjDRIXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 04:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D197
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681806184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1e6yNdquB4xsiFuNvOIM1gyO7Q8DluDr1MXBiyIlSgQ=;
        b=MCXdBDWZ6bbd0AV2zDSJ0/ZCuIlDvhMO1+WzcCdyGMFJGqrNOLmUdDbGVqv3w83vo7Dooa
        x+6M/8gQ0UcyVandLRb76Bo4c3Wdrqs2JDhyY7Johfa+KrjpUjQHfX34NMIkFW3HCpwUO5
        Z96PP/EqiBVqm6LfXT+D0pouP84xtSY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-DIFM3cwZO1mK-rKlC9KScg-1; Tue, 18 Apr 2023 04:23:03 -0400
X-MC-Unique: DIFM3cwZO1mK-rKlC9KScg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f17352d605so2182645e9.0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 01:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806182; x=1684398182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1e6yNdquB4xsiFuNvOIM1gyO7Q8DluDr1MXBiyIlSgQ=;
        b=ZSzI1sZE1I+ftXGAhVFcR3bitJHimG8FpLv08ITf+BdsxZCiT9ck+mvaO5qwsGAZzB
         /Ic6tvotLPDndlSYIpsC/dmYgE0flUIx3v3Fk4o98cF5oZhWGe1Tr7fQw2ZNxL8JC+Id
         IglFLXhdMF3A1P+OyVrl9gK5fK0Bnb/PJPn7X5Z+wZiLl4TyxT6dX9MfR5OcrZfq56G3
         slc0Oq/WUFNGd7+CvI0Utoa8W2bfVzNIpHSJUbtpHWhml7VNUD7muQi0McEKYA1Qn6a7
         pcV4ZNHZ29RyIDGjbxb0sxeUEjC51d2FFWjHnJOaP5fO7fXm4INOsdSLzlrqc4OGlZzT
         xXUg==
X-Gm-Message-State: AAQBX9coPwywmqsmaigUGdsUex7EvKqCdcMoQivBhoYj+7P81nUDUKVD
        eQ7EPiXnexo9/BzKYwxazKn8efkuuefUpaYAvrzm8x9L4ytDuOjVT55lcvlFW7PdwdVvqtpdmiN
        vvxUdp3kzrqCO
X-Received: by 2002:a05:600c:4ece:b0:3f1:7a4b:bf17 with SMTP id g14-20020a05600c4ece00b003f17a4bbf17mr806384wmq.1.1681806182354;
        Tue, 18 Apr 2023 01:23:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350byrwt8zKkA6KQmn/pUpaIQr+7BvV1zUoEFWmUjX9/O3dnGwLxRgvc7EG8p6aX1EbXFc/Y2sQ==
X-Received: by 2002:a05:600c:4ece:b0:3f1:7a4b:bf17 with SMTP id g14-20020a05600c4ece00b003f17a4bbf17mr806359wmq.1.1681806182108;
        Tue, 18 Apr 2023 01:23:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-200.dyn.eolo.it. [146.241.229.200])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003f16fc33fbesm7853277wmr.17.2023.04.18.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:23:01 -0700 (PDT)
Message-ID: <d872b08538aface37cb21eecb8a793a7063c4c49.camel@redhat.com>
Subject: Re: [PATCH net-next v2 5/6] tsnep: Add XDP socket zero-copy RX
 support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com
Date:   Tue, 18 Apr 2023 10:22:59 +0200
In-Reply-To: <20230415144256.27884-6-gerhard@engleder-embedded.com>
References: <20230415144256.27884-1-gerhard@engleder-embedded.com>
         <20230415144256.27884-6-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2023-04-15 at 16:42 +0200, Gerhard Engleder wrote:
> @@ -892,6 +900,37 @@ static int tsnep_rx_desc_available(struct tsnep_rx *=
rx)
>  		return rx->read - rx->write - 1;
>  }
> =20
> +static void tsnep_rx_free_page_buffer(struct tsnep_rx *rx)
> +{
> +	struct page **page;
> +
> +	page =3D rx->page_buffer;
> +	while (*page) {
> +		page_pool_put_full_page(rx->page_pool, *page, false);
> +		*page =3D NULL;
> +		page++;
> +	}
> +}

[...]

>  static void tsnep_rx_close(struct tsnep_rx *rx)
>  {
> +	if (rx->xsk_pool)
> +		tsnep_rx_free_page_buffer(rx);

It looks like the above could call tsnep_rx_free_page_buffer() with
each page ptr in rx->page_buffer not zero. If so
tsnep_rx_free_page_buffer() will do an out of bound access.

Also, why testing rx->xsk_pool instead of rx->page_buffer?

Thanks!

Paolo

