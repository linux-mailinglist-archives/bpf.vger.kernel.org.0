Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789BF270059
	for <lists+bpf@lfdr.de>; Fri, 18 Sep 2020 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRO7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Sep 2020 10:59:21 -0400
Received: from sonic311-23.consmr.mail.ne1.yahoo.com ([66.163.188.204]:35961
        "EHLO sonic311-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgIRO7V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Sep 2020 10:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600441160; bh=k1yl2EIxSlw7hhqSSNsyo3JWxJqHL9iqJXZc99K49Wc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=C64xE8wPENCJx9loGhq409b6lgvNA6AOCodxLkbDaexlqKG8KV1SPX8QFwVTk5z9Loodzo4ZRK6KaEoKFH+Kbrg+z0n6mWUjtv3QQiWEvp8eAF49ZjtJMUzwAyBAoFPDPvo3RO0i6J17lA21FF2R3vd0TenmUgwgeqrY1UW0SNRRQYCkJL5aSzQgTPmOu7mRrdk3ljxFaWrYSlZJGqvnWgy4Cm5CAXmxahHZqcMX2OEU0XRn6zMSb9XDy9z/WYOE7Q6ApoZBzd6rVWwQ43zdytOUHld5aFiAnUfM3yeuZoy6hUurC31GYtOBRORgmb4dqZwoBYT3slmjuSnnde3qyQ==
X-YMail-OSG: PBPxYX4VM1lMy3M3KKTVcNia5VpH5qZImcep.XqX17jJiKl3FFHOeN4wtUJqacA
 SKs548XKZryOfp_tKcJzTkBPIRrI4c48DqUfPr9HciLSCB_KV_9LOuskjcc74RIeDN7GSv805iNz
 vS1Z8bUgTxu.ajr3WLuVurLpnpBPHtPyRvtLqkH_hIAJzR6Lji3qe_9XyUSpZiO5EcqJ3AJkGZXv
 ICy3IQ2pG7UQDC7nVauOWyG3suETSxY1HTk1HiKtEn.du5NbXixqICBVstDgXDohnxeSVw00lT8W
 k8A3aSuOSGoQZcxX_vYjjmdC_CiBdc_rsLFO6cmjROASf1bmC6wgV3tRE612K3XoWYyrD90So334
 jsWCE3YXo3tNnx7iuuWSYBVaNR1QhKg4k_jZ1A1LzKHEexsl8BeqKyHHhRTaalLKvUApqhaAmYa.
 O35rYeHqjTbxG9GyJLX9DNB_DCkyVbG6WZgvvmoYF_KTelFg10uATRScB26_wxRkPIM2gnSoSrvi
 X2iZTxw1KoEabTvgvCjaVUTvcyBZi7YO1EwBVJM1xmQLVlebwv_NvpicfoTISMWp6fCnNwcVcaaV
 vruzQbK4dJal8SmD6TgijhZ3NCYrY9rxLJLV5cCNtVEn48rYYJXUCSJKdodSy646BLQLS8PImc9b
 LSaDIcBS19WXYT.ZYPTKV.44jSJ9QFcEIWanWbT4ct4wucx3wlPswdDMjGor3IbIgEU8B3VVECfs
 L0nD5FCJKecRYTW1jZ_Yy8qhSX_NcP0Z.F_ktINDz7OVp2eXh8A9RHJEYMZO2LAmvja7HZenEXkd
 _mRPs4aEElnkTCOd4kL2ndxhqMhixxZd1W3Ce2RGFeJ4dLbKO0nqMT4g8rqg4JhBQukC3vn2DL39
 JefoE3HuqprcNsuAxr57MUA6aD7YfT1YibfuVt1YCu8c5nTnHMtMqAcFeXq7z6KZY4qCrTqYpp1K
 .lAWcSDmg9bT1oJhSIjkmPwIHFfHQHEYIP_UFWO5WMSzCqIQ5a0a6Dhcc8uCm8E84HDAfzydDrYD
 oR8wALFghj0.dfNlK7l6_YMw9k2SiEqxyrvPsZo_RyF6Gx8UyNhcc9kFCpmd3Oag4eAXSMXFYIJf
 D8owTbWu1fAumz3eSgT_hLnq3lY75yWU3zjIimD2eusOQ3752JX.AwXWZ6Xsnlq40iLAwu5UVp7U
 4wLRpWiry4QPZuq2V851C1RIHNAMOvGFpW1g2aM7Vwxd02r_JWP7lds103XLsfo.ES5b0ECiaFCR
 2gqfdAFYtEoqV2R3076JXmxIeaMo_i0JwPAVIvklLjj8wN1z1awRxL86dVz6UL87_9andAH_ByQC
 150r1tj3GbszBtQIMPNpdA_PgimMiFOfRxJlXjBjwU7lap2DoXKdWW3HcPzaIqut62VMxJIctgOu
 5.GzFEmpbwnz9qW4QM_VLSksdTclMuSbp8A8mCLIIFvziiNIsqrvI0HKVWoKSSUrpkAlM_56ixuW
 YKSsfU97XNGlAoA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Sep 2020 14:59:20 +0000
Date:   Fri, 18 Sep 2020 14:59:18 +0000 (UTC)
From:   "Dr. Aisha Gaddafi" <aishagaddaf0dr@gmail.com>
Reply-To: aishagaddafi2dr@gmail.com
Message-ID: <1732665049.3899704.1600441158893@mail.yahoo.com>
Subject: I WANT TO INVEST IN YOUR COUNTRY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1732665049.3899704.1600441158893.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



I WANT TO INVEST IN YOUR COUNTRY

Dear Friend (Assalamu Alaikum),

Please after reading this mail try and make sure you reply and contact me with this my private email address: {aaisihagaddafi@gmail.com}

I came across your e-mail contact prior a private search while in need of your assistance. My name is Aisha Al-Qaddafi a single Mother and a Widow with three Children. I am the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status, however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent to enable me provide you more information about the investment funds.

Please after reading this mail try and make sure you reply and contact me with this my private email address: {aaisihagaddafi@gmail.com}

so that I will see your mail and reply you without delaying, please note once again that it is necessary that you reply me through this my private email address: { aaisihagaddafi@gmail.com } if you really want me to see your respond and interest concerning this transaction


Best Regards
Mrs Aisha Al-Qaddafi
