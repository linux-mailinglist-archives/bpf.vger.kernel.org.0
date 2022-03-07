Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A524D05FF
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiCGSIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiCGSIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 13:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 088A413EAC
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646676465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvaTFVFlhoWCYTtn8OjDRzgolmWJtqhRLewxCkbzX6U=;
        b=S1V4kH34NCaqJlSSdU+O5yYEp1Pd1VQvRZHTctgahh69R8LJ2MVeMo894SwYUq14gY1ZjI
        rN2ai4IoreolhSfKUArhMS6j1sOW4tosmVhFfSpxMUy6E3pIgLgLIeYzdy7zUWqYqETXJ0
        JSSgc82U9z0F++DDEmgOLW8FQ5t6TJE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-za6doQzqNiaW0mS1R-7r2g-1; Mon, 07 Mar 2022 13:07:44 -0500
X-MC-Unique: za6doQzqNiaW0mS1R-7r2g-1
Received: by mail-ej1-f71.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso7345447ejc.22
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 10:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RvaTFVFlhoWCYTtn8OjDRzgolmWJtqhRLewxCkbzX6U=;
        b=T/44z1YOeBKHIM6yUmPw0RI3O9NI27vKSkCK9yLjko/B3xEjZ6f1o53nYKg0vfaDA0
         UTYL4LzhgWH+5ivvzfDt533b2t07Ob75uHtEDN6H+LKtmBHUuR7NUbHZBlYnvYZoTMFg
         aipAJBUs4/AA8HGInxIWvAZvDM8jcHmp3FhcNpSM+qAHlfI7UhbbV8iwD7dxp0nERKJY
         ADoFfmK2NA2U302rGQvk7hkeG9DUQmSWsvfxka8Q22GPAIEx5uDglm0Nmdj32dJULXmE
         B04wjEBaSjuAShUM/KL0k7QV/HkjfwJizqfezuesvtnA6IiLjhC3Sr/Gm0sGgGrDshBh
         pJAQ==
X-Gm-Message-State: AOAM531XWj/2Wnqx9xbbkramjRvWLtBe1tPvcwgfnlUqt0TZZvsvcWhM
        rMDthjEOWcIRdKJeOsyLdvYbQ8g32qVcayTZG/uHwXQAXZUvusTC5ECHNN8OhnQUgAVj0Hn3pHr
        W0DZkkh/BaCQE
X-Received: by 2002:a50:fc12:0:b0:415:cf24:f6c2 with SMTP id i18-20020a50fc12000000b00415cf24f6c2mr12261336edr.3.1646676460438;
        Mon, 07 Mar 2022 10:07:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzj/pMyeLnO+AfEn2FN0t9A3R2NI1Knsz32MsTNlmQ9802qYDQkMJbnNQPxXHlXJvIMBYiyYw==
X-Received: by 2002:a50:fc12:0:b0:415:cf24:f6c2 with SMTP id i18-20020a50fc12000000b00415cf24f6c2mr12261215edr.3.1646676458949;
        Mon, 07 Mar 2022 10:07:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm6701819edk.42.2022.03.07.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:07:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C2ED3131FDB; Mon,  7 Mar 2022 19:07:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH net] xdp: xdp_mem_allocator can be NULL in
 trace_mem_connect().
In-Reply-To: <YiZIEVTRMQVYe8DP@linutronix.de>
References: <YiC0BwndXiwxGDNz@linutronix.de> <875yovdtm4.fsf@toke.dk>
 <YiDM0WRlWuM2jjNJ@linutronix.de> <87y21l7lmr.fsf@toke.dk>
 <YiZIEVTRMQVYe8DP@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Mar 2022 19:07:37 +0100
Message-ID: <87sfrt7i1i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-03-07 17:50:04 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>=20
>> Right, looking at the code again, the id is only assigned in the path
>> that doesn't return NULL from __xdp_reg_mem_model().
>>=20
>> Given that the trace points were put in specifically to be able to pair
>> connect/disconnect using the IDs, I don't think there's any use to
>> creating the events if there's no ID, so I think we should fix it by
>> skipping the trace event entirely if xdp_alloc is NULL.
>
> This sounds like a reasonable explanation. If nobody disagrees then I
> post a new patch tomorrow and try to recycle some of what you wrote :)

SGTM :)

-Toke

