Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D1272F62
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIUQ4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIUQ4v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 12:56:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C96C061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 09:56:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 7so9541098pgm.11
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2cWQzq1LTiKKRHEcQWGBOZoP8zSGp+9C9CbVvr/YoL4=;
        b=eoO4Y2n9J4T5+eImRCa+Ywqg6HUeBGeo1rEttDRW1JDjVr0elp0WN0qbKhP6gchAMb
         vwto2tKEPwMPceYIxGXpdYPOdpNlwVSKU5lGly7V89TBN2BhAZGRrM0ee6GIAwUJ9ycK
         f1m4GvBeWNz0uT2IscnVEkIyJfCKoo15LhRXBFeA7nl50wtFY1iTfMusp7pXrw9NqdI2
         dHKOhVEvl6ejJSYLMjxMCgOyY4mA5KOmysQ2MWPdy//GTIuh5CK265+OX1BAcUQ6cJG3
         5UmMKdbRiOGELVM7cW/fArkY2BpPRleSIOw7hd/NDMdleAD/VhsHvjPL/E+SS5/py87v
         DaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2cWQzq1LTiKKRHEcQWGBOZoP8zSGp+9C9CbVvr/YoL4=;
        b=MOWf/rPwhUhwi1CapQp1180I9HP8ziQGS/xqAKRAYUpchvF/WYQ+HgsotFQm0lpVD3
         cD4aMKpfSTXcQikkCJnlgJlN2xqIVk9McqZNqgsZKaZ1R9YhI/EiEivDIrno++4YEtBt
         PdPR6dnrkLpmDRtX87r5L4F7GwlHI+H6jlPekLH1MGb2Ks3/3NfI7SH+834Xob0KziSN
         WGi3MzuZO4JRggkLcVWazAxnoHuHgrHn5T0MbcSfqnEknEuJ6UCo6/dRqIidnYKbz9HI
         ogyjh35i7kiL8g98NlpOha2Sxaf9861WAjwknGNXOG7yzeGb0eo0onLffEBTxkesoKvy
         kgIQ==
X-Gm-Message-State: AOAM530oDeD2zP/ml7gam9oIU9XVh3M1w9SK+ftTLsQ07Y6Jkq8g0FWK
        rWejlBbwy8/Gw6P69jX2/Ic=
X-Google-Smtp-Source: ABdhPJwskQu3Miq7l0co2weuIj/YlhnYnEvK8DTqD5u67V9IxPoE+/gTi4013wv6I36PLK1JmKW5tw==
X-Received: by 2002:a17:902:8341:b029:d2:29fc:c400 with SMTP id z1-20020a1709028341b02900d229fcc400mr864112pln.5.1600707410284;
        Mon, 21 Sep 2020 09:56:50 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id y3sm13430126pfb.18.2020.09.21.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:56:49 -0700 (PDT)
Date:   Mon, 21 Sep 2020 09:56:43 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Xin Hao <xhao@linux.alibaba.com>, ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Message-ID: <5f68db4bfe4a_17370208fc@john-XPS-13-9370.notmuch>
In-Reply-To: <20200920144547.56771-2-xhao@linux.alibaba.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
 <20200920144547.56771-2-xhao@linux.alibaba.com>
Subject: RE: [bpf-next 1/3] sample/bpf: Avoid repetitive definition of log2
 func
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xin Hao wrote:
> log2 func is defined and used in following three files:
>     samples/bpf/lathist_kern.c
>     samples/bpf/lwt_len_hist_kern.c
>     samples/bpf/tracex2_kern.c
> 
> There's no need to repeat define them many times, so i added
> a "common.h" file which maintains common codes, you just need
> to include it in your file and future we can put more common codes
> into this file.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---

LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
