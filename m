Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6905162F8EB
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiKRPKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 10:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiKRPKh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 10:10:37 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB43E11A06
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 07:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewj9BiZhCRdgws416lQ0QkUMlCks6mNR/esLETBszRrbuYiDQ/+Q6do+gfrQ5cwqPCxex09zb4Svg9fInuewQcpSGN7UiQKfRNirWEliWFOtlr4VqLTsAoKoPv4PafteoUuo4oQW9FDO98xwdD/fO2K8iRMkMhtiyURjN4jAfrtxFFP2/AJHZ9BNHNjTZD50mvLoZ3BY23HAqpWLGj2s/x7B6/FNrrW925e6GOZMAIy1jOqlu6BlQmznyYUYz8GPWUMdLyOakAa/9deymH1MaYF/dVSOgS+4+MuD/nOsc9OxQPwxiDboEFydZhJPDj3B4EjWG9fvIwKpxaOwyIKvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+qYk/7Ehi+oRihIllCYiO9Y7MtKNvDHJFQu7SGXlm0=;
 b=ThxVUQiLp68oaXzP3OnWGMUzBZ2OLbEmGxNhHcWjhS0nnDYYR++SSbuPZYNSgL0Rkly0cX9wAp+kbN1Rc9xYyiTT7K+VmRY7FqWUrL6l/gSVIJ3fGl2P0do//qBsm4L/YtFHL0Uc9+2BisNQoJ19CorvU2Sv2mxcnfVQl3JzCejcV+L5VzRzsmuArdFXOx/aP0ZWxyURkv6tom5NSSvx6/slfCX18lCc9xJvfhOTqM3ICvJI8XpUYUQ2RdK7dSZ6jFY3eKCf46/eFuJ815UrDRIwHhXF7is3FPWxzYaNm1mDZ2jdfD8qGdHFHDLPfX5AXGpKt1cC4fcs6OSMLoUciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+qYk/7Ehi+oRihIllCYiO9Y7MtKNvDHJFQu7SGXlm0=;
 b=eyTMOW57fHggZYSOsEASkqUwe9TATLqyEE2WL6V+3x5RuwIwOFfUCucprKmZmxPRcPR/e7Js7jiHKDD6C5BmVe6Jp0qOc1gciBwB2fA5IucvuTyJ4v2NeTqEH8yxlgZAnYzOWWGb9ULh7bUs3CLo1W3A/w/Isd5BTyS2yyJSGLg=
Received: from HE1PR07MB3321.eurprd07.prod.outlook.com (2603:10a6:7:2e::16) by
 DBBPR07MB7642.eurprd07.prod.outlook.com (2603:10a6:10:1ef::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Fri, 18 Nov 2022 15:10:29 +0000
Received: from HE1PR07MB3321.eurprd07.prod.outlook.com
 ([fe80::22cd:6278:c974:5e27]) by HE1PR07MB3321.eurprd07.prod.outlook.com
 ([fe80::22cd:6278:c974:5e27%7]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 15:10:29 +0000
From:   =?iso-8859-1?Q?Per_Sundstr=F6m_XP?= <per.xp.sundstrom@ericsson.com>
To:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Sv: Bad padding with bpftool btf dump .. format c
Thread-Topic: Bad padding with bpftool btf dump .. format c
Thread-Index: AQHY+zjUZPX3IHWbF0SkGbqCbLQ5N65En92AgAAkm4Y=
Date:   Fri, 18 Nov 2022 15:10:29 +0000
Message-ID: <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
 <Y3d9mYrkWjrkJ9q2@krava>
In-Reply-To: <Y3d9mYrkWjrkJ9q2@krava>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR07MB3321:EE_|DBBPR07MB7642:EE_
x-ms-office365-filtering-correlation-id: fe53406d-9c68-402b-b5a7-08dac97707db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IOF0p7Bk2JkcrwMvu4DANZrFPZLos3l7dz+M02o+U1qTIhkXm51H06FLlTqIwEcGU/aFCZuS9oEK6cjGq8R/3TnCyUhE5pwtavvepIxIau0iDgYmI8XTc+5W+OUHOQwhwRBWLBfiDr3ZANFt0UkcMSB2AbqdNxhMIOdX58UVjjgcLcejb+nXkvb0dufPbVBDy5WcOHqfBBNjbiqE5GSc0/GsCr/GCI+Mgn8bo0jmNwwCuuAVYs3wXP8VPt+qmHuoz1qhg1Lhh9ibAHjDhuJPKltEdxslPZIn5fVcWNd/erWyuiCd8XU4M6HZgE+ipblcL7J7e2RAF2txqQX6IPC3m5eHDTvxkcGQiuP4CM971TfjNOIVDx78frWz5Hvnh5XFgQhe9NKTsl1SdE8dPxUE8lsPW84BG9KOAGUsslwH+WNwsi4U7D9vKN3UnPmO7t2Q3RHhccz/Ivq8hlrgPXUIkKii6XqJUpfu5XBPz+RSIt8jBQsN+ocVVSjnhMkMyv9uiahDeJgcLDbWdOO/02NZNhDkcJNxquS0aD1H6+p/1Rbm2lPpDib0WRYVU0B/kd5+68uHVddnfu1rbKKkYxzq7c/T0m8jRT1pkW8PafA6czBpCfvlPygpF/jwiRSZpDyW7TBtKGydj5J/FM38+A6Ud3WG8cz0Jbmtixo1M+G6MMzF2vbZbdqFjRwDOVlviVnKMwAP+jrsmgaAwEqjMzuQYtsdFCRC/X2bUny8CSfznQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3321.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(71200400001)(6506007)(7696005)(110136005)(478600001)(2906002)(52536014)(91956017)(8676002)(41300700001)(66476007)(4326008)(64756008)(26005)(66446008)(9686003)(66574015)(66946007)(5660300002)(316002)(66556008)(55016003)(186003)(33656002)(86362001)(83380400001)(76116006)(122000001)(82960400001)(8936002)(38100700002)(38070700005)(129723003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F9WXRkELwtRe2mhz1DlKhum/gyPOO8dAew4ZNAwSFQXh522b9H0GNtOos/?=
 =?iso-8859-1?Q?v1MwFqQfJoOc4BlI8m4/grIj/SP4MKPlfHneQBnBobR/P53vVbhj7xJW0q?=
 =?iso-8859-1?Q?V2XhH/4fb+GKtHZ8QUn4UF/oLzSJfkKjgBWNXIen6CLtkwTfVG6uypA7g8?=
 =?iso-8859-1?Q?HM0nX74BZhwpdfAV139R5dP+CxOI2uJNgQM3lMXaMeFnAq0EHu/9jqiDUw?=
 =?iso-8859-1?Q?wzipRToqv7FjZ05Q0TQfFd/ggTq8Bl6SNv9k8PCVcPPM/rybJj1QetwW4x?=
 =?iso-8859-1?Q?ruyQTlKJqdadiAbuzl+4AfulltVPgSwxlJustgeh0pjiixQFuWEeQpTMFN?=
 =?iso-8859-1?Q?d+V2mXCGRfzV9//255BBFlLrcWexBKbzEkGujAOTy8S0HlaLzNILTLzLWZ?=
 =?iso-8859-1?Q?ZjIPDNSQajFYqdsaZ2v9jtiyL7c+f7LS4OmMvfiifYD7gO84Aoawe6ECnx?=
 =?iso-8859-1?Q?0eqDCLdS996eI+cJ1VNreNFIK2g7DPsbTBhiPC4nNnbOGFzpxRK+Epnt2e?=
 =?iso-8859-1?Q?KQT/ab7gRnOdJboIhYyxzWSbXCOUxOkRsEmlQWy46wMhgGXU86eVDCsi8V?=
 =?iso-8859-1?Q?0o5jcrIqOjHNmFGWXyciMbkjW3sC4w/abbW0PqjGjfo9YDeKaxwpCBtdjc?=
 =?iso-8859-1?Q?i/Pg8CBLSUS5VickQzF+93kBBEWUsofVtEvHm9hHivv7YUi4YXVgbaQr5D?=
 =?iso-8859-1?Q?5C4QJJIV6G76QTkfml1eudsroTAoGRLvZDDYHyVIHUcyt9dHAsCCzk2/XR?=
 =?iso-8859-1?Q?bzMVQzcPvd8+4ehwl/CAgNCYLYiW+w4lE3Wd4s9jhnC+uEw0a0GC0aO1oV?=
 =?iso-8859-1?Q?hS+Nq6JU9T9w1snxf0+U2vFzZ6p3cVgg1XSHn0g6UbNuek+Hum3ZM1HXZM?=
 =?iso-8859-1?Q?UD/bTMI7XQmoz7Se0Krg1CfCxjpv4xQevCLHjZ2efIEAS5ur4ps2D0nveK?=
 =?iso-8859-1?Q?Enou3/aepH8MfHrymFJLaVh1VvXHFRfIbsa9V5PAlCYhI6PucLk1LA/26N?=
 =?iso-8859-1?Q?oG7/Xbd4w9nteNVeZ4bioC4ItAYHzGKIf1hmiejR/dBpqLkEwgKH3Ofs+4?=
 =?iso-8859-1?Q?UzSHklpxgct7EtANKVal0EahIKOuao10Nu5qKBlP5+qw/VG8IKcJjOIwqb?=
 =?iso-8859-1?Q?ynKN02WGSIVoy727LxneINlxXO/DS2XIU424gxJsF6/KgspBRVZGUg262e?=
 =?iso-8859-1?Q?nsDSYFzdjM3xwCcR74WoAnfyARyS7VI+LIJgZGZhI1BWhYtNciSX17x8Vj?=
 =?iso-8859-1?Q?gkZceUz7NKRoPuHEYY2pqxQ+wRziktTYcdD3sTDwwJn2v7RycDtpnPEfAW?=
 =?iso-8859-1?Q?pYFi6YDChMK/TVLPa7F/Q6xfplS2Q0U7yv4rMPkgAKHdDnZi83+PAHRsjn?=
 =?iso-8859-1?Q?ml9WAR6pFZdLqaWiveVVTyHeE+KUPTGEAl1cO/4jWnOsYkV2hEkn6Rf8tp?=
 =?iso-8859-1?Q?DJiWfiAWxS6d9spD2ADA/OgsGqOginQzp23srqRvYuPOw3s8dMnZNQnzLi?=
 =?iso-8859-1?Q?aL2sC4d102pfD4mxFFLraY1gguIz5xXKBMjXjoywihGj8naKMjQlvkE3a7?=
 =?iso-8859-1?Q?FU91xSz+VkZdDFJhetm8v5XValrNgs78n0j+MO20/uA2xqnckU/2dyT+VQ?=
 =?iso-8859-1?Q?YLjIi+ZELabEhFq5oG4Azy0u4w6+eoGLOJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3321.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe53406d-9c68-402b-b5a7-08dac97707db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:10:29.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAHS6F2Ey2mUzVgZaj+0vBrqA9VCIKVGpGHsw/m0m0+tS0oj+Khvg5awOQ4z2d1EJoKZhyQzqTu8GS7QnRvC9lUqmMn9WqDqT3iHasisPCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=0A=
=0A=
> On Fri, Nov 18, 2022 at 10:30:50AM +0000, Per Sundstr=F6m XP wrote:      =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
      =0A=
>> Hi,                                                                     =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>                                                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> I don't know if this is the channel for reporting issues with the       =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> "bpftool dump .. format c" function.                                    =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> If this is not the one, please help me find the correct one.            =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>                                                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> This bash script illustrates a problem where 'bpftool btf dump <file>   =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> format c': produces an incorrect 'h' file.                              =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> I looked into it a bit, and the problem seem to be in the               =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> "libbpf/btfdump.c : btf_dump_emit_bit_padding()" function.              =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>                                                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> I can dig into it more if you like, but first I want to report it as a  =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> bug.                                                                    =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>                                                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> Regards,                                                                =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>=A0=A0=A0 /Per                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
          =0A=
>>                                                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> ---- bad_padding bash script ---                                        =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> ----------------------------------------------------                    =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> #                                                                       =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> # Reproduction bash script for wrong offsets                            =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> #                                                                       =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> cat >foo.h <<EOF                                                        =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> #pragma clang attribute push (__attribute__((preserve_access_index)),   =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> apply_to =3D record)                                                    =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
      =0A=
>> struct foo {                                                            =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>=A0=A0=A0 struct {                                                       =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
          =0A=
>>=A0=A0=A0=A0=A0=A0=A0 int=A0 aa;                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                    =0A=
>>=A0=A0=A0=A0=A0=A0=A0 char ab;                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                  =0A=
>>=A0=A0=A0 } a;                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
          =0A=
>>=A0=A0=A0 long=A0=A0 :64;                                                =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
              =0A=
>>=A0=A0=A0 int=A0=A0=A0 :4;                                               =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                =0A=
>>=A0=A0=A0 char=A0=A0 b;                                                  =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
              =0A=
>>=A0=A0=A0 short=A0 c;                                                    =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
            =0A=
>> };                                                                      =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> #pragma clang attribute pop                                             =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> EOF                                                                     =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>>                                                                         =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> cat >foo.c <<EOF                                                        =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> #include "foo.h"                                                        =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
    =0A=
>> =0A=
>> #define offsetof(TYPE, MEMBER) ((long) &((TYPE*)0)->MEMBER) =0A=
>> =0A=
>> long foo() =0A=
>> { =0A=
>>=A0 long ret =3D 0; =0A=
>>=A0 //ret +=3D ((struct foo*)0)->a.ab; =0A=
>>=A0 ret +=3D ((struct foo*)0)->b; =0A=
>>=A0 ret +=3D ((struct foo*)0)->c; =0A=
>>=A0 return ret; =0A=
>> } =0A=
>> EOF =0A=
>> =0A=
>> cat >main.c <<EOF =0A=
>> #include <stdio.h> =0A=
>> #include "foo.h" =0A=
>> =0A=
>> #define offsetof(TYPE, MEMBER) ((long) &((TYPE*)0)->MEMBER) =0A=
>> =0A=
>> void main(){ =0A=
>>=A0 printf("offsetof(struct foo, c)=3D%ld\n", offsetof(struct foo, c)); =
=0A=
>> } =0A=
>> EOF =0A=
>> =0A=
>> # Vanilla header case =0A=
>> printf "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n" =0A=
>> cat foo.h | awk '/^struct foo/,/^}/' =0A=
>> gcc -O0 -g -I. -o main main.c; ./main =0A=
>> =0A=
>> # Proudce a custom [minimized] header =0A=
>> CFLAGS=3D"-I. -ggdb -gdwarf -O2 -Wall -fpie -target bpf=0A=
>> -D__TARGET_ARCH_x86" =0A=
>> clang $CFLAGS -DBOOTSTRAP -c foo.c -o foo.o =0A=
>> pahole --btf_encode_detached full.btf foo.o =0A=
>> bpftool gen min_core_btf full.btf custom.btf foo.o =0A=
>> bpftool btf dump file custom.btf format c > foo.h =0A=
>> =0A=
>> printf "\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n" =0A=
>> cat foo.h | awk '/^struct foo/,/^}/' =0A=
>> gcc -O0 -g -I. -o main main.c; ./main =0A=
>> =0A=
>> printf "\n=3D=3D=3D BTF offsets =3D=3D=3D\n" =0A=
>> printf "full=A0=A0 : " =0A=
>> /usr/sbin/bpftool btf dump file full.btf | grep "'c'" =0A=
>> printf "custom : " =0A=
>> /usr/sbin/bpftool btf dump file custom.btf | grep "'c'"=0A=
>> =0A=
>> #---------------------end of script -------------------------------=0A=
>> =0A=
>> =0A=
>> Output of ./bad_padding.sh:=0A=
>> ---=0A=
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =0A=
>> struct foo { =0A=
>>=A0=A0=A0 struct { =0A=
>>=A0=A0=A0=A0=A0=A0=A0 int=A0 aa; =0A=
>>=A0=A0=A0=A0=A0=A0=A0 char ab; =0A=
>>=A0=A0=A0 } a; =0A=
>>=A0=A0=A0 long=A0=A0 :64; =0A=
>>=A0=A0=A0 int=A0=A0=A0 :4; =0A=
>>=A0=A0=A0 char=A0=A0 b; =0A=
>>=A0=A0=A0 short=A0 c; =0A=
>> }; =0A=
>> offsetof(struct foo, c)=3D18 =0A=
>> =0A=
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =0A=
>> struct foo { =0A=
>>=A0=A0=A0=A0=A0=A0=A0 long: 8; =0A=
>>=A0=A0=A0=A0=A0=A0=A0 long: 64; =0A=
>>=A0=A0=A0=A0=A0=A0=A0 long: 64; =0A=
>>=A0=A0=A0=A0=A0=A0=A0 char b; =0A=
>>=A0=A0=A0=A0=A0=A0=A0 short c; =0A=
>> }; =0A=
> =0A=
> so I guess the issue is that the first 'long: 8' is padded to full long: =
64 ?=0A=
> =0A=
> looks like btf_dump_emit_bit_padding did not take into accout the gap on =
the=0A=
> begining of the struct=0A=
> =0A=
> on the other hand you generated that header file from 'min_core_btf' btf =
data,=0A=
> which takes away all the unused fields.. it might not beeen considered as=
 a=0A=
> use case before=0A=
> =0A=
> jirka=0A=
> =0A=
=0A=
That could be the case, but I think the 'emit_bit_padding()' will not reall=
y have a=0A=
lot to do for the non sparse headers ..=0A=
  /Per=0A=
=0A=
> =0A=
>> offsetof(struct foo, c)=3D26 =0A=
>> =0A=
>> =3D=3D=3D BTF offsets =3D=3D=3D =0A=
>> full=A0=A0 :=A0=A0=A0=A0=A0=A0=A0      'c' type_id=3D6 bits_offset=3D144=
 =0A=
>> custom :=A0=A0=A0=A0=A0=A0=A0 'c' type_id=3D3 bits_offset=3D144=0A=
>> =0A=
