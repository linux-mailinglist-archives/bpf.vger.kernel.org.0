Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAD64BF61
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiLMWeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 17:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiLMWeG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:34:06 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D801D0D6;
        Tue, 13 Dec 2022 14:34:04 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so14405273fac.2;
        Tue, 13 Dec 2022 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/fFeUAjkN2sqCp/aWpmlhYqWcosd7bu4zCqaYFPx7tU=;
        b=fSFyvv+rGf7AeNxmo2f8BBkjF+DdH7K8ODoyHhIQtDHrcsYEJNBf++k9FH9D/8D7+o
         GyEzGW6O+QyCDS4jE5xbuiCHjvXJWoGaiNVBss+EZlhBCt07NzgsVPc7iIk0MZboufC8
         ZZXe3h62JXiXsh+6k15xuByJ3xnDiDefvkCNQUH7FBM3xqTsMj1KnbYjsX7WDUY/2Ys4
         NdOlFHFSPKFlaFqOrdbx9Lja7rLUOOjQ53c3ufSHeF3n0OR+Bwfjph0zywBU1e4E7lcT
         HbCdcfZofTu81uf4CbVPprZayLWJsBq/orOuFi57spUXHjM8mEJOT6jjOTTn7TWqlI3T
         K+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fFeUAjkN2sqCp/aWpmlhYqWcosd7bu4zCqaYFPx7tU=;
        b=BF3beeiY0abMEyDLGnj51rNuYeJeapxnr3Daln4jcRQ72k5mVZWL11U6qpa9PfR9wz
         IoaYfrp5zHvLnMy2cnnqYTGKdY1B81rMhfbg8DTDPTzVzvJxvIS7w/WD21Z7f4uw9t73
         thv2U3dOdlXTurknW/sArw6Oz0mxlCi5ieDsw6v5fnNAUdMrUl6vaXnuC8Ee464jIjRE
         774MwKVnY21qdbOPzDfAcG0eUIQTz6dcU3na3IBFq22y+9wdjh5f8HOwhX+yDsUaVsg2
         QUleDs9gF3NjK53DEB/tmLL1HPzZgoVl3QTFy94DZT64uXpJLJtbmedqDuzkCQdDNch1
         lqmg==
X-Gm-Message-State: ANoB5pkoMhm7luOeKZdZAQtCAfTS7/sGphGERhv6xEvUX7J2uUGC/bky
        UoXYhLoIKGDPOBPZqx+UWwL2nfoQ3NY=
X-Google-Smtp-Source: AA0mqf5E4RwQTasX6iyRJ7VELlNhdyDlkpvYi7MNhdNlFd0rLZjuEctPuXdf8b8hBIAygKL2/2xmxw==
X-Received: by 2002:a05:6870:314:b0:13c:a5d1:35d7 with SMTP id m20-20020a056870031400b0013ca5d135d7mr9803405oaf.25.1670970843420;
        Tue, 13 Dec 2022 14:34:03 -0800 (PST)
Received: from [127.0.0.1] ([187.19.236.93])
        by smtp.gmail.com with ESMTPSA id l32-20020a05687106a000b0014b8347e1e3sm428649oao.12.2022.12.13.14.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 14:34:03 -0800 (PST)
Date:   Tue, 13 Dec 2022 19:33:42 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fVVPDo_3cjKmumEVKDN2Zssz-ZU=nYVQFNr1xUGHxx-PQ@mail.gmail.com>
References: <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org> <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org> <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com> <Y5DNBZNC5rBBqlJW@kernel.org> <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com> <Y5JfgyN59dSeKbUP@kernel.org> <Y5Jl8MeW90DXy1wT@kernel.org> <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com> <Y5cxyk3OdgFXlyhS@kernel.org> <BB236C92-3505-4DAB-AE28-A55F74EDE161@linux.vnet.ibm.com> <CAP-5=fVVPDo_3cjKmumEVKDN2Zssz-ZU=nYVQFNr1xUGHxx-PQ@mail.gmail.com>
Message-ID: <927374FD-C6C0-42B3-9F93-5379A5898FB3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On December 13, 2022 7:09:07 PM GMT-03:00, Ian Rogers <irogers@google=2Eco=
m> wrote:
>Thanks Athira and Arnaldo=2E It is a little strange to me to be using
>the shell to do a version number test=2E The intent was to be doing
>these in the code:
>#if LIBRTRACEEVENT_VERSION >=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>vs
>=2E=2E=2E
>LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE :=3D $(shell expr 1 \*
>255 \* 255 + 5 \* 255 + 0) # 1=2E5=2E0
>ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt
>$(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
>CFLAGS +=3D -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>endif
>=2E=2E=2E
>#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
>I'm a little selfish as I'm maintaining a bazel build and a single
>version number to maintain is easier than lots of HAVE_=2E=2E=2E tests=2E=
 I'm
>happy to follow Arnaldo's lead=2E I think the test should also be
>greater-equal rather than greater-than:
>https://git=2Ekernel=2Eorg/pub/scm/libs/libtrace/libtraceevent=2Egit/tree=
/include/traceevent/event-parse=2Eh?h=3Dlibtraceevent-v1=2E5#n128

I'll fix that, and in a case like this please consider to send a patch wit=
h your preference, I'd happily
graft it=2E

- Arnaldo=20
>
