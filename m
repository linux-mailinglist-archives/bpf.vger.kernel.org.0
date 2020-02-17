Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD4160BD9
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2020 08:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBQHqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 02:46:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgBQHqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Feb 2020 02:46:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so18334976wrl.13
        for <bpf@vger.kernel.org>; Sun, 16 Feb 2020 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5qkKrOlcFFXZzVNv9icrocjiIlH9It8BWZdzD0LWt0Q=;
        b=nVwzAvmsNR+X50r3nGA+fAKqm4lVqop6F9Orm0R72w9u0QJH/wgbx6ALhdUWwKdPfZ
         rjuB4z7AJVDPUWjpfqGwquqJcbU7zoyj4AzStg0E64CPVyz4YIt8MRHIZgFMGArJmNBk
         aC9N3DvtmoG6jepAu1+EVe98hhZeaZzKRyw6ZR8lzwLGqfrWlFPuCWhti3+3X3a77h9B
         eenMFaN1CGdlEX4vF4AOpDLedZ19hyXcCzg/t51WAp78AEzQ9hVjScoV8FQyHDq2n6RQ
         hiS6+bajefP3Bh83xlyQwTdl+wVKaRWxVTOeWPxtfSlpPvQlDDYreJWe+cRVIeIZpmoD
         e0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5qkKrOlcFFXZzVNv9icrocjiIlH9It8BWZdzD0LWt0Q=;
        b=uR7UCg3N6HPxTsIb9gLppRYIBdSl8uiZy4qkmoT/yW12RLPZiGPiZ24Y3EEnAvAY69
         rtmHHH2ZEOSl0qURUM79mH7rbWSK1ZaJOG3oSHhdKUNF/ThCa/2H1WdzA+dfGYys3Ecb
         3q7zLSHNYhH0jsBS919rYi7spGPorAdFXUfZVDOLbzTJqi8rC6cHv9yvn60NjIveWc11
         P8ckgEH3zzePkjoh1xmC4ksBVp6tIx7gl6Q5Lu+56g2SHEC+ATarZhSBtPYnIYnR2WS8
         jrmXSnvsAYK/FDbWYu+2LBOhWyi3zKqAP/pGvmUqP+i7fcgjVYw7Hos6mJqZatR29/1T
         MidA==
X-Gm-Message-State: APjAAAVzwTBQRWhR8yr9CVNKwqtpXjYNazT7t/NFOwNXwAoLXUmlmXsh
        Dbrdlidtvv7u4p8CaOMfpqIjvw==
X-Google-Smtp-Source: APXvYqxJK1DF6QQA+j344kfPjdKZ9FNScf9ZQaa/MQTmBHsoNElLwtb1YxsehCFRWbNrdn9YAQ7Brw==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr20797979wrv.144.1581925571717;
        Sun, 16 Feb 2020 23:46:11 -0800 (PST)
Received: from apalos.home (ppp-2-87-54-32.home.otenet.gr. [2.87.54.32])
        by smtp.gmail.com with ESMTPSA id f11sm18786744wml.3.2020.02.16.23.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 23:46:11 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:46:08 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, jonathan.lemon@gmail.com,
        lorenzo@kernel.org, toke@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: page_pool: API cleanup and comments
Message-ID: <20200217074608.GA139819@apalos.home>
References: <20200217062850.133121-1-ilias.apalodimas@linaro.org>
 <20200217084133.1a67ae63@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217084133.1a67ae63@carbon>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 17, 2020 at 08:41:33AM +0100, Jesper Dangaard Brouer wrote:
> On Mon, 17 Feb 2020 08:28:49 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> 
> > diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> > index cfbed00ba7ee..7c1f23930035 100644
> > --- a/include/net/page_pool.h
> > +++ b/include/net/page_pool.h
> > @@ -162,39 +162,33 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
> >  }
> >  #endif
> >  
> > -/* Never call this directly, use helpers below */
> > -void __page_pool_put_page(struct page_pool *pool, struct page *page,
> > -			  unsigned int dma_sync_size, bool allow_direct);
> > +void page_pool_release_page(struct page_pool *pool, struct page *page);
> >  
> > -static inline void page_pool_put_page(struct page_pool *pool,
> > -				      struct page *page, bool allow_direct)
> > +/* If the page refcnt == 1, this will try to recycle the page.
> > + * if PP_FLAG_DMA_SYNC_DEV is set, it will try to sync the DMA area for
> > + * the configured size min(dma_sync_size, pool->max_len).
> > + * If the page refcnt != page will be returned
> 
> Is this last comment line fully formed?

Yes, but that dosen't mena it makes sense!
Maybe i should switch the last sentence to sometning like:
"If the page refcnt != 1, page will be returned to memory subsystem" ?

Thanks
/Ilias
> 
> 
> > + */
> > +void page_pool_put_page(struct page_pool *pool, struct page *page,
> > +			unsigned int dma_sync_size, bool allow_direct);
> > +
> > +/* Same as above but will try to sync the entire area pool->max_len */
> > +static inline void page_pool_put_full_page(struct page_pool *pool,
> > +					   struct page *page, bool allow_direct)
> 
> 
> 
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
> 
