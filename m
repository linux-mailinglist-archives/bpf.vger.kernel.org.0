Return-Path: <bpf+bounces-4863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41648750DCF
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711581C21173
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA021507;
	Wed, 12 Jul 2023 16:16:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE8214E1
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 16:16:24 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FAE4D;
	Wed, 12 Jul 2023 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689178574; x=1689783374; i=markus.elfring@web.de;
 bh=hAvjQeCs1XdLs9B1cYNcTRKKEbCVLUNw3SE220eXZ/I=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=kJLMfiTE2hXNp7LpFf7npVB5c9y1u8wAnRPoc8aBaltVPfcvGtN7A9vh+w5AteJVGfKtIzb
 TzrkumqDlWjI2sXi6KOLttUt0hI/fMd5YXVl6ZtlQD9ANE3JTUaf5G4ny1hdc5C5uNDxTHGmp
 aiExf0gp+Wr6Zk0VRnbPE4VASJSjxJSabgbMqaMDPyj+SlFxf977zfX44XSDMb5yX2WEKjezX
 SV6FODWBc3tj8XyjdCH1gPYwgy5uvLXcuHDK5bBPxr5UkBha86zej9t12wIcSpBUdR578P/Qx
 VRsx7lF/QqKuPyG+d262zhtGNq4aOxXAc9TeavY34UqZ1XbHkggA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1qMMKu15rq-006YwV; Wed, 12
 Jul 2023 18:16:14 +0200
Message-ID: <8dd0bb16-0089-dff1-928e-ec30e61be45c@web.de>
Date: Wed, 12 Jul 2023 18:16:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Minjie Du <duminjie@vivo.com>, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>
References: <20230712131630.16552-1-duminjie@vivo.com>
Subject: Re: [PATCH] lib: fix two parameters check in ei_debugfs_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230712131630.16552-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dEnq21uZWjqUUF/m2gm01WDb8jWSvqeg25ebgxN6RdJhQ88DqTO
 AlzEC7Jkuajr6ZwCJP2K6Q5tJ3R/+90D8HtG5JOh2iMA0gg8KfSV07OEkmUQKc1kPgTRbms
 B5s5OGYFyeoiSEVMPar9OhQWKf7EBOSmLRDTklKOGGpMVO29mKZpv3GTlwBxKzoV1AC2+Vd
 QKnZxh9s4aKBzuz+WB8pw==
UI-OutboundReport: notjunk:1;M01:P0:+GN9spQddJg=;yuUEYs1gEC46YeA9FN6ICJOOpOF
 JuGcm78WyYGURIXMHc9XUVh4kZUxMc9d/HFxfS/qaKEojCyCw0kNL7Y22jKuHXfZ4jbxUu/2h
 78BpkPiqxLnGJGpmx/1gXZWhbpj/tjdh+QeCtE9lHFdBBcU9k+YAbHwOXQmcISeYYP05KU1g8
 9nYo5hPUePOE2R1IQioD1N5RFhGogbkANp1iSsl9+Gv1cS7p9fUL6T2kceI9f2+AG1s2w2Su5
 bWv5FB+Lo6v0OxZsTDqhFVR5iQhoM0E2fnEmuu3nHE3cJQde0YAAXV0XdZ4tqyQ3VTY8hrKrU
 1b9UAyKZMPQ7UJOtyt8Y+Qhtk6T9PmnHqA2QxqBTzvjaLF0iDvaJz8Moh+Kwqr2vIfQ6ZqDMA
 voDkGHiAUBKo//riGcAWooaLZj8Oc1MeTleCbLd6iotWNbTDjnCKf4x+6uDHHymBsjyhBx1Ee
 m3hnLdsElP65v+tNgUyhjGP6abjdusdXgQV4RctR20mnZtuYKauEVedB1IcMxxRHxcVW/ScHL
 8G+YoNazYtNUVdmVh5d+Zw/u6lkNSXvkjIPI/KCw+0JucyVgafRhz/WNeRkkWWVEQrUoOUgnA
 3o1lOrRCvGkTF7W08cnq1FjCiZOwx1qmX/2r+9RcioLNi5xXXiDkfTOkKHSB7Dx8L70V8UOZZ
 2ZBYzimEBU8nOrwr1plHxswokyqKKmxJTWqpWIZWtaqEHW/nN3kxOD4o4vM8P1atNcV8EooKy
 6Pp47I7liHux3eq23Y4x5QR2PeUcsBG9Gbn/t9JsPszXpX0YSfy0nAOAQNVupCpg9Nso8+W1/
 d7We4H6MpjL7ZoKyLLk7bi/9d4q8fgWjXG2mzDdt0GCgc7fRZlNgZnRmjM8ZQ7okJGIIFQekV
 82N9iDuIInRRLaIVc3RNT5RMYMBI+MiABg+j123SmSciUKu9UahcdVgDyD+yqCqMEjlU5CHk0
 cX+Vl0IaKkn7M7JJunyVYbkq++I=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Make IS_ERR() judge the debugfs_create_dir() function return
> in ei_debugfs_init().

Would a subject like =E2=80=9C[PATCH v2] lib/error-inject: Fix checks for =
two variables in ei_debugfs_init()=E2=80=9D
be more appropriate?

Regards,
Markus

