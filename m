Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498F5E5E48
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiIVJRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIVJRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 05:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0016D01FB
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663838232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQfJsNBklEQnlLpVZNYjFz1njaLl7T8B+cRrquogK3o=;
        b=MQuMr1Msbygvu9jvS13AdWjOLEv46trP1DZ+JQfLRfFH705N3f9huXwv15tiLfoip1Ca5J
        ZLp1IB6F9l5Klc+/rIwbJe6eZwLrIYmSyRFZqek5dJRMHFv1ZYDkOH52Z0u5Qm1RF2Ukpq
        e+8EToPxPMYngYUMa1bG0ENFL2Nd1SE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-438-DOVI1nfwPNKJnjLw30nUNg-1; Thu, 22 Sep 2022 05:17:09 -0400
X-MC-Unique: DOVI1nfwPNKJnjLw30nUNg-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so6209312eda.19
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 02:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kQfJsNBklEQnlLpVZNYjFz1njaLl7T8B+cRrquogK3o=;
        b=BUW6QX4dj499+t56lMce0Mkg1dEt+Jq8zD9Lv1gcbhm6Jse38bHRn9UiFyU1gXMglS
         TQkW0WN8lahbFvLUo/iNdaLcUoq2Y0noGSBL+aq7eFIRNJrfIG0O2/IxCm5tA+YpucoO
         UCg0mHHAChoiwoNUnAuTPCjAR8YHOXmtOmiJpKb9vkn2JayyDNjDi3AUfUGaeC6rilLx
         bk9y5eRXmL4EmjRThY8K5yzbn3OaprmO+JKGSONKF0hEHmTE4HP7qSHnt8slpXRF3COx
         SKFYm1Rzv2ZRTjnGyL6Hql9OK+6Kc9z74LUpRHyTKQY8cS1wVDjyWR3SyYHwGUGyxCcf
         sTMg==
X-Gm-Message-State: ACrzQf2IpSQ6kT/3Ej2CTk97AFFlz4XLdeZaxvBIGVDhw5kzy5mUOl99
        ckP0fVX1WQAvDjeLOHPchCugepxIefhv521MpMucM87nGmt+1Ps2HnYkoucUsb+S802Ykl8AUce
        9ji6T/lXci5dA
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id gn7-20020a1709070d0700b0072eec79ad0fmr2019350ejc.296.1663838228508;
        Thu, 22 Sep 2022 02:17:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6aWYk2gLkly55RZes2gWKaV2mpYmlQSmVpIR2XSzCn6t3IkeaTpYNPXd0NwzuX13AYtWwYqg==
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id gn7-20020a1709070d0700b0072eec79ad0fmr2019336ejc.296.1663838228336;
        Thu, 22 Sep 2022 02:17:08 -0700 (PDT)
Received: from redhat.com ([2.55.16.18])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906304e00b0073bf84be798sm2374187ejd.142.2022.09.22.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:17:07 -0700 (PDT)
Date:   Thu, 22 Sep 2022 05:17:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Junbo <junbo4242@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220922051613-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
 <20220918081713-mutt-send-email-mst@kernel.org>
 <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 22, 2022 at 11:10:37AM +0200, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> > > hi Michael
> > > 
> > > in virtio-net.c
> > >     /* Parameters for control virtqueue, if any */
> > >     if (vi->has_cvq) {
> > >         callbacks[total_vqs - 1] = NULL;
> > >         names[total_vqs - 1] = "control";
> > >     }
> > > 
> > > I think the Author who write the code
> > 
> > wait, that was not you?
> 
> I believe 'the Author' refers to the author of the current code, not to
> the author of the patch.

Oh I see. Responded.

> @Junbo: the control queue is created only if the VIRTIO_NET_F_CTRL_VQ
> feature is set, please check that in your setup.
> 
> Thanks
> 
> Paolo


-- 
MST

