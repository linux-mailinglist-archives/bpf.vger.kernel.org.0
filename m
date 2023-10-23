Return-Path: <bpf+bounces-12963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7AA7D2891
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 04:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8065B20D4C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 02:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD1A47;
	Mon, 23 Oct 2023 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RJK+1Qnq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B451841
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:34:10 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B7AD51
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 19:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/LMPA6h7u/CdGsmmffNdWLoEUZ138TUyYKGUifGhxocDprMzSzZjOnWBNiUrQ14r3GxJw5dBEayswD8CIReKUBfGsO5J7mrqa6iP+vVT4V7R/sC9rNavfoiFVZodw8spN9hQzGOQie/6nlZx2ZrCYJYfhK7AkP5yE5lPgEr3Ji08GdShYFaMJqsXuzrV+8kr39APaQOFnANTfgw8nQ46s2Ycc08y2TsghQLZD31D1oIsz0uGrt8CHPwRQVnvZ7Xl3+fve1ofMnwEYX1JI976IbsPq0NSCltgAkm3NzylMMeGLRiFTAmtwua4tyagRj8b04sYEP7/3tgk365azycCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oxC8yt76Tmfpq23JHgljSACFmJyergv4l40mwuwvO4=;
 b=KNt+UwbsHtWh7nr3ytln1d7ZIWZqblO81cCQRjmVjTqKe1o1VNQa7trtcp9cSm1bS50nSiYIvnLNqWDPBBl0RKIp/OfWZwk9kly82dePfRYPo4TV1MK/oEITYxUnUaTxdZqIm/o8n5+CDRYFxBHs74A4KhAjHDHRRMe3rKhMmVZTznffL5QT35hJb4JFbmSvBuiW8SsR7LDHeX6Fgoubdg1FTuw//aCav8Ia1zs+UCIV5mE8vIc0UhafBJCuhua9PN3paJS2yd7zYg1KoDnfzzYGf/9iyCFF2SIbUJCvDwi/hw8my14PsRynWA4fNbUk0nY7XhiQpHc5Y37wHV+cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oxC8yt76Tmfpq23JHgljSACFmJyergv4l40mwuwvO4=;
 b=RJK+1QnqI9qqo4FIRvkHcXUn/f5vjwkXgzgi+xT7YU+px5eBhoEqBTF2LTDKNVqJN14vCuMBO3n2T8TSjhYIuexAXKStUFrclJxlVUX3E6dzXFy8hAnqA22KZiZ13J0UwTfdYuCuNPGe+b1fZN45RCpJw+8tIa/ZmIHDe3/8FqdrOYjzDvVuj/UZZTzcVpPhDDvNjdJ+2anRZu0ipxbYYFQf0HMbi/InOwxLTfT2vguKEuvcEMV9X73IEAriSF5hOHTsYrecJJk8k6q7UPlwGXjS1IprI+HV9NM03P0wPAVo0EO+Lx/DwwYLbBDa+Gz0f67ll8ikRM7kLxwjvpqUkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DB9PR04MB8219.eurprd04.prod.outlook.com (2603:10a6:10:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 02:34:05 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 02:34:05 +0000
Date: Mon, 23 Oct 2023 10:33:59 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 bpf-next 1/7] bpf: improve JEQ/JNE branch taken logic
Message-ID: <ZTXbl7MsUlXgg9d1@u94a>
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022205743.72352-2-andrii@kernel.org>
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DB9PR04MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae78ea5-3e9d-4f3a-84c1-08dbd37086c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tzXrdTQBELbEzAxlqV156BwwsRs6IKrp5nFgWE5Ltie39JLbBrjyuqJmZTDKGJ1vv2ZRwKEsN4fhaJLUeOd/OwQTbTT/nKiL0xMH/31iwBMDD+AzliQ4wDS/D8gte/8At88Nv/jG2nCKuH1M50/FwGJt18wtSQzbbt0AqdEUqcwbtbKxJGIdyPXLoR7PduGFlaTFFGswP4iJnaf+0eddmRW9y8RR+6LDBCXlaCMMrHtikHuHvYYMAiw97rQeH/wcFyjQMMdj/XAP/NjGEIUWY1z02zCOTDLSTMeTkY/RwA1OYFJ3lehUGODVnJLRPTe8ZNi414l1zOwkUW6YzyD1zG3RQjaaaJc17FT88r2DOLNK0m5zlXERDioRUz1NDSI63SB65AfE5fKqUtfzv/lPqJ0ntWSxW89FpAgy1TR/afnhv6E0ctyFTTFeOif8RJl3FPU6E5NDG3i5vSu6tdV/NVLo9h0WhXxaOj6tjrRmKAMlSH96OV4LfnufH65XOpvT1zmoukcrnuXNaJFO4XkQF4NRRx96pAGq0GC1p7w0EjX9Y5/Q7G5y3FDuBE6fzD/E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(33716001)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(8676002)(8936002)(4326008)(6506007)(478600001)(6666004)(66476007)(66946007)(316002)(66556008)(6916009)(83380400001)(6486002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkwvNktpSTlSaExGblpKM08zWllSOHJzb1I0VGFDOTR5TFFsSkVHTmx5SFY3?=
 =?utf-8?B?bk05c2M5R0ZTWlMwMElKOVNEYW1kWWlYY2NzQU5oNzcreitDK1VIZjNUOGVL?=
 =?utf-8?B?T0xES01DekFWd0ZKdndVYWtRQW1zZDZjNU81dk9MblhJZXhoWVVHNEdMcE4v?=
 =?utf-8?B?Ry9kdW1MQVcvaitoZFNtUmJqQjQ1a2VOZkZ4UUJMTmRHUEFVanpLY2UzeUJE?=
 =?utf-8?B?emRqRjVhSDdsKzFQTENLZUJxdk9JSlREZHpJSTVNRlVSeTFXUEIwbVVsVlBH?=
 =?utf-8?B?eVJqQUFzSnNhZGkyQnRJc0hRd3k5ZlV0Y256VVpNM1FCVEJ6Z3ZhaVN5dUFF?=
 =?utf-8?B?bk5MajlmU1FJWVBDSVlwalVmZGZ1L2JNQ3hDQ25IdUY1WDY4OUZZS1VxWjVZ?=
 =?utf-8?B?TE1ndS9QQmx3UUJnQlNrYitqdEhIR2ZSTkZuSUNneUlQcjNoU1NEVHhEeTFG?=
 =?utf-8?B?QTJIbDM0c3lCL0JTUGJtRXZ3MG5xaHNoREZNRWRmei9OeVJ1cTQ1QWc4bE5u?=
 =?utf-8?B?U3dJR3hRdjFJNDgyeGppdi8xamRoRVB1M0VCL0dMSnRMSHBUdXdEUGpiMm9s?=
 =?utf-8?B?UUdqZ1NUelduWHI5U3lkZy9JMVdqWlJDNVlRNUlUdFhKOEppWVpoTUFlVWM1?=
 =?utf-8?B?dUg5aUJ2dHZrTU9ha0pWV21sL3VjVFJFNVpzMUVmd2E5bFc4ckpMay9yaDN2?=
 =?utf-8?B?blF6dWlkcmM3bElsVFJCK3lOaEk3d09sdWprc2dwZ2NMSVlvQlpwalVQTEJX?=
 =?utf-8?B?Z21lbldySyswZDBiY2w0d21XSWhmSlBad2xUYlRmS21qQkJxcDhBeE12TWs0?=
 =?utf-8?B?TjVnT2tmUENDM3RIVTZ6N2Z5a0JMY0Y2NDRDUjBsbFdzT0tlUEp6MS9vNVkx?=
 =?utf-8?B?Q1BtNjdiaDdqUDc4L1l1SlVDeEJLcVZwcWJYbjc3Q05KZkhpSWNuemVDRnI3?=
 =?utf-8?B?Y1ZhNldDaTJ0NytyR2ZoWUtseVQrTmFzYVZwSm1mL09Ud0p3M3h0YWdXbzAv?=
 =?utf-8?B?NWZpL2hVMzNmZTBnc0p6M0JrMncxcEhZMUZMYTZmNWUxVzVhUGZpbWYydXlv?=
 =?utf-8?B?Smd1M0dZOGpubWVhcU94Q0FQRGhKbHZxTjM2bU5qaGRoQVVldUIxV3g1ekt6?=
 =?utf-8?B?czFKSFZEcGhmVDN4UStoM0VOa3hoeXZ0VytEQXlWMzNvSzlqbE1HUUI3Y1dQ?=
 =?utf-8?B?WXFmNnoyRENxbFk2VGhSN1BLV0o1UlI3elUwNEg5Vm8rNXY2SU1mQUIxMGxj?=
 =?utf-8?B?eXczb0cyT1NwMFZqdW91a1R3TUMrT1hqdDVZVDFMUTZYL1NrVmpXRTZEeklt?=
 =?utf-8?B?WklHY2ZvZDV3dGZtcjBsOHdSS25zNmlpV1oya28yUEpSbHJKaDdtUzhkeXhR?=
 =?utf-8?B?bTU2M2tBb2o1S1puY294WCtqWkE4aDVMNVZCYWJBaG9LRWFsWmE1K2FZaTc2?=
 =?utf-8?B?bFJ0THM0MmRIcTl0cGZnU3QrREVkcXZBK0Nobm5OWEJ6cFlEL1ZFOU9DZ0RT?=
 =?utf-8?B?aVhma3p1U0QzamNpS2hlTE9oTHJ2KzBMMkRicHRNVjBEWE91bHllZTUrYXFu?=
 =?utf-8?B?TjdneVB5V3ZXb1ZSdmx1eEJiQVZyVmpndi9xZVdFTjhoTkd5Zzg3NDhsMUo0?=
 =?utf-8?B?eTE1ZVBBY3JKcXVQUXBCb0owd1VETDJZbGlOaW9La29lVUFnSnZZUExONDVU?=
 =?utf-8?B?cEtYby9VWEYwUnp1Y09YNk9TLzhFOStGU2RiK0c4L3Jsc0hoSFJ3L054bUlv?=
 =?utf-8?B?d3hhUDRWa25MM3g3YnluQ2R2ZU4yU3lrVVMycFJMenVicnA4VFVoTzNaUlk0?=
 =?utf-8?B?SWNXeklJcWtSdHl5Ti9jcXV0cXV0ZFc0RVZyUnNSc2Jqd1ZYc3Z6YWU2Rzhm?=
 =?utf-8?B?Yk9JbkJiNzlQVUZVSEtQUlZmdmlHeWtyN0pjWnhIcEhSKzRJUWZoTENSblZz?=
 =?utf-8?B?MHh2RWxSUDU5WjZ5OTI0VUJqKzJNOXJhZUdzcGhVYUljM3IzZzgrTzA5c3p4?=
 =?utf-8?B?STEyMlhvTmlPYS93eWhRSFcrR1A3QUpoVlBlWXlRUFpkYnFUTURXNGJLK0Nx?=
 =?utf-8?B?UjhWalV5cjZjVWZIandTbEJIZHg4SWNFNmF5a211Tlg2Mi9jVWE2Q1M2dGFp?=
 =?utf-8?Q?wI/mL/Ha8ZRUvsr5uH8+goMTl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae78ea5-3e9d-4f3a-84c1-08dbd37086c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 02:34:05.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogyy54lcAqHjsuMj3SYwJlKq2qPKdQETRMjE87WJmfSGjAm83y6eROnrTjZqDcU1qYUSSQkMUMy4atLgNIezTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8219

On Sun, Oct 22, 2023 at 01:57:37PM -0700, Andrii Nakryiko wrote:
> When determining if if/else branch will always or never be taken, use

Nitpick: "... if an if/else branch will ..."
                 ^^

> signed range knowledge in addition to currently used unsigned range knowledge.
> If either signed or unsigned range suggests that condition is
> always/never taken, return corresponding branch_taken verdict.
> 
> Current use of unsigned range for this seems arbitrary and unnecessarily
> incomplete. It is possible for *signed* operations to be performed on
> register, which could "invalidate" unsigned range for that register. In
> such case branch_taken will be artificially useless, even if we can
> still tell that some constant is outside of register value range based
> on its signed bounds.
> 
> veristat-based validation shows zero differences across selftests,
> Cilium, and Meta-internal BPF object files.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Otherwise,

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

