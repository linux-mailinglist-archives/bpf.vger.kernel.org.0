Return-Path: <bpf+bounces-5956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E251763795
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F3D281EB1
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006BC2D8;
	Wed, 26 Jul 2023 13:30:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DBC141
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:30:44 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243CFFA
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:30:43 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 055A3C16952C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690378243; bh=H4fyuaRcfYJOcl4K+5vtV6Hz8JuyrjwDd2KFKc841l0=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8krPJGRH63f9qaYX2+ADJQIQ8eW6PMzFBP5sgD7orpnkqqCGfzOLpKL3Hou5ZOpT
	 zohONhlVNd0WIG1RQgo0WnDKHO4GPky6/PAnVrZ8T5RcSApFX6N0T0MpaJuuBP38Oq
	 PRqe5VBsLOHNnDqaHJ+No1NoGUs6Cqax5DIKyeJ0=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id DBAD0C169514;
 Wed, 26 Jul 2023 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1690378242; bh=H4fyuaRcfYJOcl4K+5vtV6Hz8JuyrjwDd2KFKc841l0=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=O8+wmcc3ZZZsi5mj9NxQudpujj+MPRhHPGZY/8Uexr083Jcf6UzVb6vLx8hL9aEz2
 VxUJp7rbLnYRrh67ita9JIlBNTKRclt6qX2Bo27fxfSP2MtKDWD06dAcrIG+YRgYpk
 HNrGKp3RP7DmEzExHtL3zZEjL7zFbhdaM5vTaAfA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ED5CCC169514
 for <bpf@ietfa.amsl.com>; Wed, 26 Jul 2023 06:30:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.111
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uBr6u0TgtkO0 for <bpf@ietfa.amsl.com>;
 Wed, 26 Jul 2023 06:30:39 -0700 (PDT)
Received: from DM5PR00CU002.outbound.protection.outlook.com
 (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1BC83C16950F
 for <bpf@ietf.org>; Wed, 26 Jul 2023 06:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPMff0nXh6ZPeALBnnntuSCrqdrpKHYyfPdcgKJqZCmWx1JwG2+QTLsZ1riT3Xb1M991WMYjrFPpHWLPNaCMWfpNyw9QZ0sYu+FOzZjge9guTp2aTtudSYRA+xyp+/GIsIKpzzi5FVYK6738Phmq8HRD7pPLyZx4cNf2j6AWqUaJ7UBXYizRXoKb2bzt9K76GOPhvLVQcjHHKiii6JMdcQf0iivC8pTZCJ7ieYDgRqBtYHgdZgJKcVDvQjX4JEWUa7Q2TwoBJHvNkL+W5U8rVKi/MooUPyl4sWsaILOdRCWqx+TwNNzFz4QBWo0QPL2pnbjL+2D+EmxVZzsc3VC+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7xr/JEE2seYh7QAf+uJqREqJ9jOykw9aQAGaGcMVU8=;
 b=n16V7PqBvWHxE40FIKX0ZgHVC5xVHRrlN5vsoGlJIPm9FKOzj1d+lAR2YqcCrWI7MMs0X7O9dia9bwrIz9gXKyO3YdC+9SQZX+qHDYDKv9sWnhFJW4KhV6CSAr1b5gh9wnsUOT2YbIheo5a7zy5bBFDnlF2h1SDrfn1Hce0e6WIHF3ZhOJvxMdx1UH/iZRmmrPds0mhFccu6IByACw+q6B4JFEQB8BAwo+X3XZOcOxsaAQGytsZ0sAESY89V2A4uZ4Ybf4rkHc46HpqATr0FST6yq7lH5mNV2YhLLnDj1ekqR2lhOVTutVv/p/hrkN0j2N1mUEoiBrlyVdmvOAqODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7xr/JEE2seYh7QAf+uJqREqJ9jOykw9aQAGaGcMVU8=;
 b=dJ0unbe5kI3ZDScS9bNIdy2KMc0PBZmNZhgZzObWcS+pCO4RUOlPy8xH7B25m0mAizagdQNZqjy3AGj8S4nZ5nroAkpHKwQeHJmPYPkB/fPOL1xCK+we4ertubyTU2Hm9MxfL2Ak8nMLE+Rf7bligR5PwKAfvlX9CXLNeHButwg=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ0PR21MB1951.namprd21.prod.outlook.com (2603:10b6:a03:295::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 26 Jul
 2023 13:30:20 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Wed, 26 Jul 2023
 13:30:20 +0000
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
CC: Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>
Thread-Topic: Register constraint in NEG instructions
Thread-Index: AQHZv5wBBWkxWbz+G0+wUnH4/7J2Ha/LxMYGgABGUKA=
Date: Wed, 26 Jul 2023 13:30:20 +0000
Message-ID: <PH7PR21MB38781B2B296EF741290F8685A300A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <878rb3842z.fsf@oracle.com> <87y1j36nhz.fsf@oracle.com>
In-Reply-To: <87y1j36nhz.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b066f623-aa83-4eba-a3c6-3acc560854e1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T13:29:07Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ0PR21MB1951:EE_
x-ms-office365-filtering-correlation-id: a8b74412-9d83-4455-047b-08db8ddc754f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PG2FbrXqKkeEjHO53wI4AaK6H/WXAxdn2PmydHYlmBWFV8p6dkwcYty863ZiVBRfFMCNOv5h+rpEamLg8NR9ZXhdAqqaStGCQAaOQpOugPGySo/ELLuetaU8XvAae1QFyosBBdBtbvA+3kCLrFEzcPyt6r5XYsFLjcxVkdOO2RzVeDVC/Rk2BmvElXrBrt+dpVWmltWyHnvWexmoeg4mSgVA8yqlrEdWnBIB3vERWcTi8KYL95uZEEqC5NAA44wUUAZqyHAZFe+G5009hpYCk+akwq/7tz3vbTnAtbwbUKzuhc4SGmHXEUO7u5nZhuAa1SZAITBXaYMFd4R6b4GPpd1PhrZo6mefk/hdYmwG6pjPQPOiqiAfraD8UyBSympUW1eQIU4vShh0GGfW890RcmWJETwMUMNqEf+rUhw1T957BbwmoPEYdOs0fyjLH8Fc2rqQUObhHh2RfhiQFFnl8Hfckchkbdd+oFJ0qaBgrwoxtsGbp351rF6y4vTRYXqN6RAhaFUMAn+EWEzOl04/S9P1E73clI+zQrxEquFsol41z8RZaTthj0tCip0M9aWJi6RV+Tm38v/qoZLECt1+e51U8xFFUl/OFlOJPDkO0AocpbcX0kbnMPH5SaTXwjWhri8i4bs+jwEKMAVucebX+fSeLIqzLy7QxOiB6eyTKVo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(6506007)(53546011)(52536014)(54906003)(110136005)(8676002)(41300700001)(8936002)(5660300002)(76116006)(66946007)(4326008)(66446008)(66556008)(66476007)(64756008)(83380400001)(316002)(9686003)(186003)(71200400001)(7696005)(10290500003)(478600001)(55016003)(2906002)(8990500004)(33656002)(86362001)(122000001)(38100700002)(38070700005)(82950400001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aX6FsVF12YFr6BwzvooGQSxTHCVzjTvUxWMa+c9pt0D7ePrJV+RhtVnrnfUh?=
 =?us-ascii?Q?6cWrhtzs2IP4++jhvJQn6yZfBW80jEXxN6NDvym6I17pJuLuM4XE/0ABWco6?=
 =?us-ascii?Q?7lUgwb3L408eL2Chr3D9RhfDpMEfdp/jOuzEV4vuT7PnGUL4xN0T+vAJiSay?=
 =?us-ascii?Q?DEHv2Aa3Pg4bzrdCTsCbFMev+tRWgn5WmtbquIjHDmaim82VrFCzX3y8QZ6v?=
 =?us-ascii?Q?ScNvnHNVJMXKm8JqLdHsGoalBuvs6RRWu3KsxDHiMA9CoQTNtalnZOGplv31?=
 =?us-ascii?Q?B3LsC5TQqShSw+tTXHISpYEawxODr5zC3S0yjGQS+7hT9KG7f2g7npa3PoHJ?=
 =?us-ascii?Q?y6NSbdiBBSALRMpbUVD2l+5YFCL27enWsem5j/TWIqhy/anrnnqE2Vezl2pk?=
 =?us-ascii?Q?MzZmSAfUdSnmIRRXGIrhr7cMh5FqBl8sBnJ5TLHx4PB414wGB7iLqsS0XtQB?=
 =?us-ascii?Q?SHc9uhcK8aRcuj7/pjXG7/Hqn7AbWLwv/kq6PVjyekSnQg6ksrwVOpoVl9DW?=
 =?us-ascii?Q?Ag1HX1wr7q6NceMcI5+qR7FFAzXFBCqFCk6qyRY14XJ/6chXrBiXQBQpUvbQ?=
 =?us-ascii?Q?MHIzse48z2vxEDqj13/HdckV7I5oaSCokTFlrCrIDrfoBEoZ3geDQeXfoFet?=
 =?us-ascii?Q?LCU/Fz0X17Orb1xbjVKxVLHDfp2FGGmCgMFakEhXc2Dzh/IMUk/GBUVkZ8Da?=
 =?us-ascii?Q?QoDwfy7YVUHBgyc+ct40N1+c4qTbF7IGRLIhU8pLVpnqnjQub3qYNArhIgbw?=
 =?us-ascii?Q?B4yRbkc0u6mnhVIVzf/GGrCPhkIvZBGU6csFQgjbvzT8upu5M7v1gcFw5qq0?=
 =?us-ascii?Q?IDpCIvQ1/8JAq+CsxdU1SFTZytndl19fFDvvYimJlebDdIfSBi46ofdbwwTV?=
 =?us-ascii?Q?im10nE6kfbWJE3VmpKtL2pkJ/J7DjzjGdpQrqMkG2BpY2Mepaq4HnDiEpSCx?=
 =?us-ascii?Q?8hJ2fJS+vXZL/Jn+kP5ugUnpt5zU7bBXjSDtGIi+QPBLOdHl4gPSRxZHXoXa?=
 =?us-ascii?Q?zjKx/JOH0iMQpbX6nSJqaMtOeXW1FKZeV25Q2db8aRnTpUMZg2cddGOL81tT?=
 =?us-ascii?Q?WLCxcewdsBzZtUft7Lcz+Qlj5cdgE1JkYOnylRbFKxhVhkCkG24MevuwchOc?=
 =?us-ascii?Q?ZELJsd6CrQ3TveQaqeUolQXJrg2A6XwFbpSKXS+HHXv5C2n9UiIOyzXkIU9t?=
 =?us-ascii?Q?cebQLJ28XP1aZlyfdnWIkurSle++G+YMQbWjqb1cZ7Mjt0O6/Pt0smwoTfv2?=
 =?us-ascii?Q?MO39HmhaeUErZ/Jrsj+SSuWAbsXS7K8Pfm69TcVZo0UcFfp3+XPiKJSQvRmY?=
 =?us-ascii?Q?w8nevDEiLfXmQuhEnrtBzFD/dqAxJVPLO0dELPUpM3OX6aQgXwS5SxAwBvnw?=
 =?us-ascii?Q?4wN10XzOF6oamTpgobGxL+5aKkz7qTd8pZn0q+Pqv7e9Tt/OHKgst5DFPRgU?=
 =?us-ascii?Q?5Tpu3/S0IcXVavwXy7hnkUzJdBjIRkRhwllNM/7q5SmlWchWyuBLs6deJmnc?=
 =?us-ascii?Q?Qk5KEZV/HG+JZLmsscw6kDzHPWEx5nfAHpHN2DLmyjiZkHp+qykgMwiEOCHY?=
 =?us-ascii?Q?pADWiIv52sTISBsab1L48cP5AcKx934pZCf2uXMhU+Vi7d0Ae7ywKicmAMl8?=
 =?us-ascii?Q?kSizzERMH9BrKqbOwYK5l8rw3p9b7pL4br1s5Wq8qkb986b+c5q54IpWa3uA?=
 =?us-ascii?Q?PtCkHA=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b74412-9d83-4455-047b-08db8ddc754f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 13:30:20.3484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AlBcyw1bl7+6xGyPRujIPDHMrzkX6hHbAJ78YAQlY0APwEYTQf6hR1H9z5kwbSCYZse76ACZPVq5o57idr6hKxHB6Nk0ap4Um2A02uqqW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1951
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Sb4YT-4mxBrqOm648NCk7spFfnk>
Subject: Re: [Bpf] Register constraint in NEG instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Jose E. Marchesi <jose.marchesi@oracle.com>
> Sent: Wednesday, July 26, 2023 2:17 AM
> To: bpf@vger.kernel.org
> Cc: Yonghong Song <yonghong.song@linux.dev>; Eduard Zingerman
> <eddyz87@gmail.com>
> Subject: Re: Register constraint in NEG instructions
> 
> 
> I see this in the verifier (bpf-next):
> 
>    if (opcode == BPF_NEG) {
> 	if (BPF_SRC(insn->code) != BPF_K ||
> 	    insn->src_reg != BPF_REG_0 ||
> 	    insn->off != 0 || insn->imm != 0) {
> 		verbose(env, "BPF_NEG uses reserved fields\n");
> 	return -EINVAL;
>    }
> 
> And along this llvm assembler test:
> 
>                |
>                v
>   // CHECK: 84 01 00 00 00 00 00 00	w1 = -w1
>   w1 = -w1
> 
> Is enough evidence that NEG is supposed to use only dst and not src.  I am
> sending a fix for standarization/instruction-set.rst.
> 
> > Hello.
> >
> > The neg (and neg32) instructions are documented to use (and encode)
> > both src and dst register operands in standarization/instruction-set.rst:
> >
> >   BPF_NEG   0x80   dst = -src
> >
> > However, in llvm's BPFAsmParser::PreMatchCheck, it is checked that
> > both source and destination registers refer to the same register.  If
> > they are not, an error is raised.
> >
> > Is this to speed up JIT to different architectures, some like x86
> > featuring `NEG reg' and others like aarch64 featuring `NEG reg1,reg2'?
> >
> > Should I send a patch for instruction-set.rst documenting the
> > requirement?
> >
> > Thanks.

I am adding bpf@ietf.org to this thread, for context.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

