Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AE5F524E
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJEKMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJEKMp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 06:12:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4119726AC;
        Wed,  5 Oct 2022 03:12:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so5625492wrp.10;
        Wed, 05 Oct 2022 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67KhfclQArB26eTbPmndMfSf+46wfLeIvrHvkgdu5rQ=;
        b=K0SUPm2aJ9U8xpfsX5IDrNt+IGprtpIkm4DZ1tdLPh/F0AHmIa01cW502LHxYgEqHc
         BQSfIzGiQRMfDWwCbLMvt7rMdpwy8Tz56O8SAxpFr+87n9f/pqUnxPOXDbKeLq/If6Dk
         yM1eiEosukowjflvpyC5cFi3qmtMhl1qJzQoxzGWyMNc0KyQ77PTCBuEjG/gzPelKXMN
         GO2vZUOyHq8JToWH3H5KkY7YHM+0AxJudmefvzbBcz2T7kKLTkFgQuXexqff2LeHtd1o
         nHHrGqH7QHF5IPbyqlXm+d1MLuk7IZPwaTXXy/KQYPokqR1CohngMTcmRDgfoBi1K4GV
         E9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67KhfclQArB26eTbPmndMfSf+46wfLeIvrHvkgdu5rQ=;
        b=HqrTN8rCM1LsGwv7XRomqIapaZn64CbvG0r7eNiO9rH8VpXMZ/1GAkyklefwajizv9
         OoZ6ToFMkbr1U1rh7fqAjbin3PpvqsGB/rph8C0jDOqV3rNBlt4FgKWATb5bupn3IKfi
         EC7KzbPj0M+cIp9wbl7RIgJmaDnjfjDnBeDPcHdOzEJGV+WWxZV5zGCvDehE9sSmiZO2
         L8ulCC1waw6ETorZs83cGBwnqtPmx7tbKEbD/J2vWGsxOaSwqaM11DbRCXlQbh8rQc3/
         PShjGlht3sdxxKjN5w66kxM+wI0worqtVqAEXF6Pz7wJ4pZDwCAisqU9VD4AFp7gxvc3
         +4iQ==
X-Gm-Message-State: ACrzQf2C9xn+3+kAjlnprbjWRC55izIQmx6AMqtvd/BBE1CIfnRzTYi2
        YiAkAK5ctkICq+xKg+o8KcQ=
X-Google-Smtp-Source: AMsMyM5DGoSMWm7UHW+RwJGMAOpb/nggYGj16/6wELeToOUiiSrnM2SX3OiDGQ2WYjBFYHC+0KDSTQ==
X-Received: by 2002:adf:e6cc:0:b0:22c:e0b9:ef60 with SMTP id y12-20020adfe6cc000000b0022ce0b9ef60mr16344167wrm.404.1664964758179;
        Wed, 05 Oct 2022 03:12:38 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b4e1:6c12:775b:a638])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b003b47e75b401sm1546142wmo.37.2022.10.05.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:12:37 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, dave@dtucker.co.uk
Subject: Re: [PATCH bpf-next v5 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <acc73050-f0a4-099d-37c1-5fca6b20136c@gmail.com> (Bagas Sanjaya's
        message of "Wed, 5 Oct 2022 14:32:24 +0700")
Date:   Wed, 05 Oct 2022 11:12:19 +0100
Message-ID: <m2y1tutw8s.fsf@gmail.com>
References: <20221004161929.52609-1-donald.hunter@gmail.com>
        <20221004161929.52609-2-donald.hunter@gmail.com>
        <acc73050-f0a4-099d-37c1-5fca6b20136c@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 10/4/22 23:19, Donald Hunter wrote:
>> +Examples
>> +========
>> +
>> +Please see the ``tools/testing/selftests/bpf`` directory for functional
>> +examples. The sample code below demonstrates API usage.
>> +
>
> Since you have many code snippets, better say "The code samples below".

Good catch.

>> +BPF_MAP_TYPE_ARRAY
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +This example shows array creation, initialisation and lookup from userspace.
>> +
>
> "Initialize the array, set elements, and perform lookup".
>
> ...
>
>> +BPF_MAP_TYPE_PERCPU_ARRAY
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +This example shows per CPU array usage.
>> +
>
> What is the purpose of above snippet? Give more detailed explanation.
>
> Thanks.

I will rework both examples into separate snippets for create, init and
lookup.

Thanks!
