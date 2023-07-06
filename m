Return-Path: <bpf+bounces-4339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47074A68E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C211C1C20E41
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AAF15AF0;
	Thu,  6 Jul 2023 22:04:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126871872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:04:05 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C31BEE
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:04:03 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9528CC13739C
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688681043; bh=z4BlhONsn03znfh6RMXpDqFsO9Ny1dabXlooHSzKTJY=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IAg0CfDVYEronKLFBEtfhrRiLSCFul6tffjpauLAguhpH6bA/ZX4RZdLNYFJ8YEpU
	 Gui+bXcsMwHF2Nya3PBY81SIC58kFelKwf9Y6JVFhF7ksfWDse9QT5tOq/JMld8XfZ
	 TKRgjUkty0GOt54Ds5Rc8M4yWalI8Blpr8XUqX6I=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 68506C15108A;
 Thu,  6 Jul 2023 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1688681043; bh=z4BlhONsn03znfh6RMXpDqFsO9Ny1dabXlooHSzKTJY=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=dxqEtQ9oM028pbfhu7rki7XWOzI6c1PUgHYgJohlyUQx/kREyWBVa8xGrwIKHgaoL
 OoRrpCE30K6NPTumoLUTW3AyQRZ5P9p33JCQxm5uxUs/0mT9HAAsNO5ev7Bq3p/ppT
 iwVK166E3SFa9/Nx56UOrZ9FdW95jNLIcl6qKzBc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8EB2AC15108A
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 15:04:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2z--q_Jwi_oQ for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 15:04:01 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020020.outbound.protection.outlook.com [52.101.56.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 812D3C15107B
 for <bpf@ietf.org>; Thu,  6 Jul 2023 15:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEqgb4KMFF0WCZqsPxRaSN5SGuG96Vm/+FHjOVqCFnn7keb87u/PY88bQV9aQIRFHwGQZ9DfOLWq5UM2LwCZy4s6Rv/BSmy/9KUBPJ/2FEPU3eVsCj9r9cj+srJ9U1mVTaJOaFe8RRmB0ggtARBKtnX/KiGaP//CCwdTIcMNruasJIq4Le8fcJ+KeqHjpiOPysJsItmJXK9WNl4t+zfDH+ZJGvdcOPxXLq2fqPznwq3f83G7YnM3xs1d6Y2k9+HwcP2dJBsdvJq5A2H0upwHbNV1rSdOCCh9frn+I3SpwKiPfSjZQFcrFnQXZNEiz3Gi5XURx0sqnnjnnmZU9m44WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJnTxmDqRtiNUKcKPISMGORZ5wsVBoIlk+O1TvFiSe4=;
 b=DQHnj0bpcfH0c1NmYF8wbjk2GTugGXc3gJk3poG9YVHhuV5swOYyKxXnoBlrfuLKkg8v+M3yW3b8aIMrPj8by6Sv0JyVtSK0V3tPlDnNdspCK/EZNHgyv9h4mof01e8p3wGeABmZTSlaYkSYXP7aL57RyJxNOKTKslz4x/uYb41qI7v1Ot8y7/uOVYQIXDBmaxz7orRN9EiNG5FKtlbk5UWN73KFafhIj0mpVFPTiuAVezFt4FmoGQoTqbW6gRPmmfTARgE+4C6kKa08QItffOcJoK6J6LC56gRqXdWEeIb0I6zWBxiLHXDO27PcYOnxRTuzvMzh27K2eIikiNaVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJnTxmDqRtiNUKcKPISMGORZ5wsVBoIlk+O1TvFiSe4=;
 b=jkYRr+g4TbMInwD6wCJC+Oa1O/lQwy6kkuZ+10OBSQV6b8dmYUnh1I6Nr1f3e3+xnuu5bLislczUOdunyBs15USOiXP1aHZwI0k/ZEb4+JUu/Hr5pGgfcGDUx0kIDP6JbfBzE3aAUGXHrekULLRSaabEEwfHLaujsiyRPIxDwZ4=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BL1PR21MB3305.namprd21.prod.outlook.com (2603:10b6:208:39a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.19; Thu, 6 Jul
 2023 22:03:58 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Thu, 6 Jul 2023
 22:03:57 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dave Thaler
 <dthaler1968@googlemail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
Thread-Topic: [PATCH bpf-next v2] bpf, docs: Improve English readability
Thread-Index: AQHZsCO6M9q7Z96ZgkeER5FbIKnIXK+tNFeAgAAMDjA=
Date: Thu, 6 Jul 2023 22:03:57 +0000
Message-ID: <PH7PR21MB3878EA22602A94F1C308CF33A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230706160537.1309-1-dthaler1968@googlemail.com>
 <20230706204159.7tzacql7wdk3yszc@macbook-pro-8.dhcp.thefacebook.com>
In-Reply-To: <20230706204159.7tzacql7wdk3yszc@macbook-pro-8.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=33618ae4-939b-4211-abd7-ec3a142f7ea0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T21:25:07Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BL1PR21MB3305:EE_
x-ms-office365-filtering-correlation-id: 901bc17d-43ce-4bda-2305-08db7e6ce558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SYOsIq3TIparMM75rDBLsiE14NWxFsThYbrzMaFlht0WDN/TsINQaOa5v76tntcJ8nlXIPmBA5KRwJEV3i75/WEbRo5LkPuy7CQ9OiPIlgb0rTOFfBX4hVu+dkfleott7U6myZ0lZkM4T1xfIC1NACm2izM43m9gSETBIjwzzHcS2zvwXl//6ph81dB7FGT6Odv23qg+QGPbKjHWtIInB+C/+DUYMka/iJWrkBRGSLYfKER8lU90UcubYnDt2CMerntiB6dpUTUhc+SrdbeeJr9+LHlQqb3meuvSgrzD/luWrYhxia/NKnx3liLfDs4j6hPWGrM3XjW+A6vF9aC246mBUUFhiLasITQQd6C7t9lIdFo2CTrIaNnbzUXVxOxNPo1q1q55DsOQy9lTiAKvZyfoG7OSJPoMBOq7Lm7gBH/ty5CY1rkfzPq99vmOWvd1z2EgCgnvzO7aS9KVjA3zM+lZxzU0LD5PBfoYJ8q058VbfveSIRrFU5tjrcwbqPbZc1d0HxUsQ8apMMyym6FG12jNLBVhUpeLtqQOj6yRIJrzYkC0z3i2Ss1y+hzXswWKkaZYePx0sj3ezTmwrR2dXcuwzjYXDA0Ryfre+xIQM2qCcCWe/W2+lkyzEctW/8G5o/RM6zUC3Ns3+OErew4CoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(54906003)(110136005)(7696005)(478600001)(52536014)(10290500003)(9686003)(86362001)(76116006)(30864003)(8990500004)(966005)(186003)(6506007)(66446008)(316002)(64756008)(5660300002)(41300700001)(4326008)(66556008)(8676002)(38100700002)(82960400001)(82950400001)(8936002)(122000001)(2906002)(66946007)(66476007)(38070700005)(83380400001)(53546011)(71200400001)(55016003)(33656002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40OqU2WpqtO6w47qnDRm5YEnV5cEdScU8YAmZmokwIWsU3LWcawd1W3ihBNe?=
 =?us-ascii?Q?NUGj1ilc6Kkna1JqFgt3eJn02HvBlyj1KcShytsiZTAURzyqXZRpk/dBH2sW?=
 =?us-ascii?Q?m9GBrjriGhPveJpeSCpj2bkoS6WinPvxqosIyFfioI2XauY3BkilCzQlx7Bl?=
 =?us-ascii?Q?tNbnXbxH7O1JgKLEDKCbLO8aVe5I0DPC/5conjIduYx/Xznji+OhFaemWrEx?=
 =?us-ascii?Q?P/l4zK5SVnVw1TOxgLQVTQdPDO8DojcB6N1RYDaxXlR79PBkDAekZ3lmwXEk?=
 =?us-ascii?Q?Oh1BoHDmfKPnL6ATNcboSyV4co5aBzKjoKRoTI5/8OMjZbeuIaFxAfPGdP7A?=
 =?us-ascii?Q?e6U17qMfw9p9Cyhenapt3mS+TU5D5ul7wfddIW2hpVzjy9BF3yu0WFI+Vi3o?=
 =?us-ascii?Q?pRe6kdbbEWaN6qLqYby5L6oBWCEgQFom1HZOD75RkRsR/lEUqA595y0KYCwb?=
 =?us-ascii?Q?POl138M3qEKi3RrneT/PT+jLkW1FolN/s3H7n7HwUSoTmSxGkfmY2agpsNt5?=
 =?us-ascii?Q?df9ugksX/banx0c62+N7ZzgLXy63YP6ya7EoqfwFkHrm/OqnV629ySY12o8q?=
 =?us-ascii?Q?AKlyMx40i2vlmUPM7Vo7Pz3kuQi5XItuVvjHQZ3nyn2Q1lqf6tKVUxKi/hcC?=
 =?us-ascii?Q?b1x0fAvd5Hc+fMf7IuPK/tsLOstXpSg8IARX9Q0ayVJ8SjWueVN9FyYLUaUJ?=
 =?us-ascii?Q?YYDzVXabCwNdgzsU19zmCfUCJY3SVNRu4LWnfCyz2L7TVYF4BVbFH1pB9wto?=
 =?us-ascii?Q?WLachF5oCWRE+r/9LcMFythdX5+NZYEvf3RwHKhol8rQFMEw5QF7DUTVJccL?=
 =?us-ascii?Q?Di3uZw4wmDpuDj/npMwYf87xWyljojXTuZs2OMhZcjvx+GEKn/jfXcY0jW71?=
 =?us-ascii?Q?Ojc9zVfvJoiJD0Eqz17iXMZTLs3s6V18sUHZd/WAj5JPZo6u+x/wtKh07JeA?=
 =?us-ascii?Q?YvpFk7pTwLJEe81dsUYucqvqazi15sHZwYCI0H1Yn2ZRv65v+44IwXlOynPX?=
 =?us-ascii?Q?ERRzMhgju0yBtXurMYPyfSLk0XtQiU4Gkx20wfzQpxm93v+4/hosMdQ6w/m8?=
 =?us-ascii?Q?2bMB9fxy37jlRMH4G7A/+hrsv2kdkm+r88jNkwni0CJg1j8kNx78n+hYxsEw?=
 =?us-ascii?Q?++pmrZEZaTH/3xaDk00wPqB2EcoRWOLfmnNilbJlVyViPx0qcA8266qyaYjC?=
 =?us-ascii?Q?eDUQ2JeLLIslp2RBXQqL+o0Nzh/pmMm5G8Wa2Y2cMUskrpJsOruiMj4dEKuL?=
 =?us-ascii?Q?T3T1fItiVhGSRE+ta4zOgq+rN5OJynNJli7uOekhsX+QpWV1pAQN+VOM/4cI?=
 =?us-ascii?Q?xu7J4mLn2k/SxgNRf3x1plz/cH3lD51w7U+1fHJ5V7bewz1GpwlYc1emRJbN?=
 =?us-ascii?Q?lPkOQSJL5QmNuPLEDwifV+9kibA6hdg6cUNXujdJbSyxZcv5QqRhNH3VPwkf?=
 =?us-ascii?Q?jdqKTGfm3jZZOojSYBYMkogSLRGi6P/nN8DWLWRCUZdtGRgyth8CfEbf6FUo?=
 =?us-ascii?Q?hQsIyxzITqRD6fpsIleow0a5tkIIEIQ5r3WQdLxxScyBUaauuzrgcDxV/Hjr?=
 =?us-ascii?Q?hOD4asew0tQtWYdk3vPJsgfiU7KqLjDuDzV04DKP1bonSQ1FWvbeFmUv6nUo?=
 =?us-ascii?Q?jQ=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901bc17d-43ce-4bda-2305-08db7e6ce558
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 22:03:57.1958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SaMXyn75X7JR9UKVLWTB7oeYMZat8r7PbGhZguTavPmuX0WM99tE6M8QGZ4PMeSi1l5xr46HzcnWsK/pGUmpBH/uBXvKXA7hRnYTKzq05s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3305
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/OueSXbJqjKG63zumOR4FFOXOWwo>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Improve English readability
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
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Thursday, July 6, 2023 1:42 PM
> To: Dave Thaler <dthaler1968@googlemail.com>
> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
> <dthaler@microsoft.com>
> Subject: Re: [PATCH bpf-next v2] bpf, docs: Improve English readability
> 
> On Thu, Jul 06, 2023 at 04:05:37PM +0000, Dave Thaler wrote:
> > From: Dave Thaler <dthaler@microsoft.com>
> >
> > Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> > --
> > V1 -> V2: addressed comments from Alexei
> > ---
> >  Documentation/bpf/instruction-set.rst | 59 ++++++++++++++++++++-------
> >  Documentation/bpf/linux-notes.rst     |  5 +++
> >  2 files changed, 50 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/bpf/instruction-set.rst
> > b/Documentation/bpf/instruction-set.rst
> > index 751e657973f..740989f4c1e 100644
> > --- a/Documentation/bpf/instruction-set.rst
> > +++ b/Documentation/bpf/instruction-set.rst
> > @@ -7,6 +7,9 @@ eBPF Instruction Set Specification, v1.0
> >
> >  This document specifies version 1.0 of the eBPF instruction set.
> >
> > +The eBPF instruction set consists of eleven 64 bit registers, a
> > +program counter, and an implementation-specific amount (e.g., 512 bytes)
> of stack space.
> > +
> >  Documentation conventions
> >  =========================
> >
> > @@ -27,12 +30,24 @@ The eBPF calling convention is defined as:
> >  * R6 - R9: callee saved registers that function calls will preserve
> >  * R10: read-only frame pointer to access stack
> >
> > -R0 - R5 are scratch registers and eBPF programs needs to spill/fill
> > them if -necessary across calls.
> > +Registers R0 - R5 are caller-saved registers, meaning the BPF program
> > +needs to either spill them to the BPF stack or move them to callee
> > +saved registers if these arguments are to be reused across multiple
> > +function calls. Spilling means that the value in the register is
> > +moved to the BPF stack. The reverse operation of moving the variable
> from the BPF stack to the register is called filling.
> > +The reason for spilling/filling is due to the limited number of registers.
> 
> imo this extended explanation goes too far.
> It's also not entirely correct. We could have an ISA with limited number of
> registers where every register is callee saved. A bit absurd, but possible.
> Or went with SPARC style register windows.

At https://lore.kernel.org/bpf/20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com/ you said about the above
"I like above clarification though."

I think it's important for interoperability to define which registers are caller-saved
and which are not, so a compiler (or even verifier) can be used for multiple runtimes.

> > +
> > +Upon entering execution of an eBPF program, registers R1 - R5
> > +initially can contain the input arguments for the program (similar to the
> argc/argv pair for a typical C program).
> 
> argc/argv is only for main(). We don't have main() concept in BPF ISA.
> argc/argv is also not a property of ISA.

That's why it's "similar to".  I think the analogy helps understanding for new readers.
 
> > +The actual number of registers used, and their meaning, is defined by
> > +the program type; for example, a networking program might have an
> > +argument that includes network packet data and/or metadata.
> 
> that makes things even more confusing.
> 
> tbh none of the above changes make the doc easier to read.

The program type defines the number and meaning of any arguments passed
to the program.  In the ISA that means the number of registered used to
pass inputs, and their contents.

> >  Instruction encoding
> >  ====================
> >
> > +An eBPF program is a sequence of instructions.
> 
> Kinda true, but it opens the door for plenty of bike shedding.
> Is it contiguous sequence? what about subprograms?
> Is BPF program a one function or multiple functions?

The term "subprogram" is not currently part of the 
instruction-set.rst doc.   "Program-local functions"
are, and the text says they're part of the same BPF program.
Hence the doc already says a BPF program can have multiple
functions.

> etc.
> Just not worth it.
> This is ISA doc.
> 
> > +
> >  eBPF has two instruction encodings:
> >
> >  * the basic instruction encoding, which uses 64 bits to encode an
> > instruction @@ -74,7 +89,7 @@ For example::
> >    07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
> >
> >  Note that most instructions do not use all of the fields.
> > -Unused fields shall be cleared to zero.
> > +Unused fields must be set to zero.
> 
> How is this better?

It uses the language common in RFCs.

> >  As discussed below in `64-bit immediate instructions`_, a 64-bit
> > immediate  instruction uses a 64-bit immediate value that is constructed as
> follows.
> > @@ -103,7 +118,9 @@ instruction are reserved and shall be cleared to
> zero.
> >  Instruction classes
> >  -------------------
> >
> > -The three LSB bits of the 'opcode' field store the instruction class:
> > +The encoding of the 'opcode' field varies and can be determined from
> > +the three least significant bits (LSB) of the 'opcode' field which
> > +holds the "instruction class", as follows:
> 
> same question. Don't see an improvement in wording.

1. The acronym LSB was not defined and does not have an asterisk by it in
the https://www.rfc-editor.org/materials/abbrev.expansion.txt list.

2. "LSB bits" is redundant.

3. Putting "instruction class" in quotes is common when defining by use
the first time.

> >
> >  =========  =====  ===============================
> ===================================
> >  class      value  description                      reference
> > @@ -149,7 +166,8 @@ code            source  instruction class
> >  Arithmetic instructions
> >  -----------------------
> >
> > -``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit
> > wide operands for
> > +Instruction class ``BPF_ALU`` uses 32-bit wide operands (zeroing the
> > +upper 32 bits of the destination register) while ``BPF_ALU64`` uses
> > +64-bit wide operands for
> 
> The other part of the doc mentions zeroing. No need to repeat.
> 
> >  otherwise identical operations.
> >  The 'code' field encodes the operation as below, where 'src' and
> > 'dst' refer  to the values of the source and destination registers,
> respectively.
> > @@ -216,8 +234,9 @@ The byte swap instructions use an instruction
> > class of ``BPF_ALU`` and a 4-bit  The byte swap instructions operate
> > on the destination register  only and do not use a separate source register
> or immediate value.
> >
> > -The 1-bit source operand field in the opcode is used to select what
> > byte -order the operation convert from or to:
> > +Byte swap instructions use the 1-bit 'source' field in the 'opcode'
> > +field as follows.  Instead of indicating the source operator, it is
> > +instead used to select what byte order the operation converts from or to:
> 
> +1 to this part.
> 
> >
> >  =========  =====
> =================================================
> >  source     value  description
> > @@ -235,16 +254,21 @@ Examples:
> >
> >    dst = htole16(dst)
> >
> > +where 'htole16()' indicates converting a 16-bit value from host byte order
> to little-endian byte order.
> > +
> >  ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
> >
> >    dst = htobe64(dst)
> >
> > +where 'htobe64()' indicates converting a 64-bit value from host byte order
> to big-endian byte order.
> > +
> >  Jump instructions
> >  -----------------
> >
> > -``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit
> > wide operands for
> > +Instruction class ``BPF_JMP32`` uses 32-bit wide operands while
> > +``BPF_JMP`` uses 64-bit wide operands for
> >  otherwise identical operations.
> > -The 'code' field encodes the operation as below:
> > +
> > +The 4-bit 'code' field encodes the operation as below, where PC is the
> program counter:
> >
> >  ========  =====  ===  ===========================================
> =========================================
> >  code      value  src  description                                  notes
> > @@ -311,7 +335,8 @@ For load and store instructions (``BPF_LD``,
> ``BPF_LDX``, ``BPF_ST``, and ``BPF_
> >  mode          size    instruction class
> >  ============  ======  =================
> >
> > -The mode modifier is one of:
> > +mode
> > +  one of:
> >
> >    =============  =====  ====================================
> =============
> >    mode modifier  value  description                           reference
> > @@ -323,7 +348,8 @@ The mode modifier is one of:
> >    BPF_ATOMIC     0xc0   atomic operations                     `Atomic
> operations`_
> >    =============  =====  ====================================
> > =============
> >
> > -The size modifier is one of:
> > +size
> > +  one of:
> >
> >    =============  =====  =====================
> >    size modifier  value  description
> > @@ -334,6 +360,9 @@ The size modifier is one of:
> >    BPF_DW         0x18   double word (8 bytes)
> >    =============  =====  =====================
> >
> > +instruction class
> > +  the instruction class (see `Instruction classes`_)
> > +
> >  Regular load and store operations
> >  ---------------------------------
> >
> > @@ -352,7 +381,7 @@ instructions that transfer data between a register
> and memory.
> >
> >    dst = *(size *) (src + offset)
> >
> > -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> > +where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> >
> >  Atomic operations
> >  -----------------
> > @@ -366,7 +395,9 @@ that use the ``BPF_ATOMIC`` mode modifier as
> follows:
> >
> >  * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
> >  * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
> > -* 8-bit and 16-bit wide atomic operations are not supported.
> > +
> > +Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic
> > +operations are not currently supported, nor is ``BPF_ATOMIC | <size> |
> BPF_ST``.
> >
> >  The 'imm' field is used to encode the actual atomic operation.
> >  Simple atomic operation use a subset of the values defined to encode
> > @@ -390,7 +421,7 @@ BPF_XOR   0xa0   atomic xor
> >
> >    *(u64 *)(dst + offset) += src
> >
> > -In addition to the simple atomic operations, there also is a modifier
> > and
> > +In addition to the simple atomic operations above, there also is a
> > +modifier and
> >  two complex atomic operations:
> >
> >  ===========  ================  =========================== diff --git
> > a/Documentation/bpf/linux-notes.rst
> > b/Documentation/bpf/linux-notes.rst
> > index 508d009d3be..724579fd62d 100644
> > --- a/Documentation/bpf/linux-notes.rst
> > +++ b/Documentation/bpf/linux-notes.rst
> > @@ -7,6 +7,11 @@ Linux implementation notes
> >
> >  This document provides more details specific to the Linux kernel
> implementation of the eBPF instruction set.
> >
> > +Stack space
> > +======================
> > +
> > +Linux currently supports 512 bytes of stack space.
> 
> I wouldn't open this door.
> The verifier enforces 512 stack space for bpf prog plus all of its subprogs that
> it calls directly.
> There is no good way to describe it concisely. And such description doesn't
> belong in ISA doc.

linux-notes.rst is not in the ISA doc.   The ISA doc says the value is implementation
defined.  linux-notes.rst says what Linux does for things the ISA doc leaves up
to the implementation.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

