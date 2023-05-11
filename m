Return-Path: <bpf+bounces-327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63BB6FEA37
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 05:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FB11C20EB7
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EFA17755;
	Thu, 11 May 2023 03:31:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AC645
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 03:31:20 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43610C9
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 20:31:17 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 72534C25861F
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 20:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1683775877; bh=qNB5bA1o6Xabkk2yxIakQInVPQJx7E3FdIk5u+PhqWo=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDjl820JjyGjKI5mRee91ibUUKrSXIsNR5fAqwdqoaSeA8I+KSDpGcD+qrPZr1XG5
	 Qp+B2RUz+VbZMotvJiMEQF6mz7vTNt5xKz1NWlLVq2zTaCPvzS0iEjTwPWbNxlgLpZ
	 q7O7kwippTRK6t8bc958bIx/+5jmRQc46vtc3zaQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 442B3C17B349;
 Wed, 10 May 2023 20:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1683775877; bh=qNB5bA1o6Xabkk2yxIakQInVPQJx7E3FdIk5u+PhqWo=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=TeJpPg5ztxd8dBAcoFL9HK0sAvtsDxr6IAphaVG1tELh0Zn/m9A6akbF3t7Q/tYqa
 3qskTnQwJzlB4AvL4eNJNJAXr5vS/txo0vZWBAbzl9AhRKJofyz/4ERUsa5KM1EiRs
 6iC6D/gRnW3IFY+TYcP1C5JLbpckKmgOlbp9/vxo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C1862C17B349
 for <bpf@ietfa.amsl.com>; Wed, 10 May 2023 20:31:16 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2QQKw2x7X8z0 for <bpf@ietfa.amsl.com>;
 Wed, 10 May 2023 20:31:12 -0700 (PDT)
Received: from DM5PR00CU002.outbound.protection.outlook.com
 (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 53CCAC1526ED
 for <bpf@ietf.org>; Wed, 10 May 2023 20:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U46q2lj+sLra0jkUEVximIBAFaMPSuJmNwkGo8Ju+Lxg7vD0teiHgL6VrSPOsZZKj9jjeZx1HAbGozw9AF5TTw/wOA5bSSMwGGVzTF22d+5c7kcsPaWy4rUJMJXmppGM5kSPbpaERjh2wTs89Chg8XiN87YO0cFbvolZuCA65nbXw0mJAKUg3NbIE+LmzJ3CkUU8d7yNL3GQd3LXICbXRQesI53MXACaWVPL6lxeP/07Lv+C2QWZT/3zpOCgU9tvRxEW8aHR24UjKMFA3faHT9ja52RTvu5xHApV8GCWnUD2ETayQSz9Sr8uWzlzeyAuure3I+O6aIlE29LYT5x1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANtsV/ggL/8+AIKKie56PvgXh2PJsWgvWMW8gnSKuP8=;
 b=Vu4Kx5ljcjrIQi54FdYZqGdFdWKXX5dn+BXsagGPyu9IQ9rBB4zVzLkc60D/Odh2aadk2TwbgyW94ZqaGmgtmkMZNmJRDWJsPeDvE90N2t6gdCVQA4ufWRVKEHQkzzJgNCDc68MrdE0+CJ15NcSiY5WMbXC2XK7Y153D9Ml0jZAWqs9LlBnVt3TgJvFRUGx58fvvTq/Xt8rcGGgN/KsL5WvQEAq3nEW6g0IP2ZToSD5DHVqaH0GQTPJ7YaZCdJt0IlAgURmTcTFzo5Bw8K+jonrZjTZCcXLdwy4+MSZCnJnsfA22u/fXxLcQOvShJF1REx4KaXRnRvi2TR2osauxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANtsV/ggL/8+AIKKie56PvgXh2PJsWgvWMW8gnSKuP8=;
 b=BjtQgSgXGqWwKRnT3vCTVVs1kY5c0P2K1cwnyF8jxLU6nYINwcYlGcepAK7L+yWkDIUPCXJwNrhuCgoAFkJJhlRCB7B0M+4fNNiFgbO3yyOYEcEmozNol9YsjbjJ+PZI/NTcIAKyTpkYGA4FjOdqdL9z6rteQgPKvuoh9dSnMuY=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SA0PR21MB2012.namprd21.prod.outlook.com (2603:10b6:806:132::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.5; Thu, 11 May
 2023 03:31:08 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%7]) with mapi id 15.20.6411.002; Thu, 11 May 2023
 03:31:07 +0000
To: Yonghong Song <yhs@meta.com>, Dave Thaler <dthaler1968@googlemail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "bpf@ietf.org" <bpf@ietf.org>
Thread-Topic: [PATCH bpf-next] Shift operations are defined to use a mask
Thread-Index: AQHZgqFZC/QeNsBkkEu+CoXwaca4N69TgxOAgAAiq4CAAINHgIAAQvHQ
Date: Thu, 11 May 2023 03:31:07 +0000
Message-ID: <PH7PR21MB38782FB8019C5574A14D4408A3749@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230509180845.1236-1-dthaler1968@googlemail.com>
 <463649c1-d641-82c8-626e-162865cc21a0@meta.com>
 <PH7PR21MB38783D142478D9D569188B5AA3779@PH7PR21MB3878.namprd21.prod.outlook.com>
 <e702f65c-0d6a-d9d6-12d7-d25d3597966b@meta.com>
In-Reply-To: <e702f65c-0d6a-d9d6-12d7-d25d3597966b@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1692f505-70d7-477b-894b-6eda7ff1db24;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-11T03:28:11Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SA0PR21MB2012:EE_
x-ms-office365-filtering-correlation-id: 3d89e5f1-f98f-4e2d-b0ea-08db51d0287d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrnKGWzpinuYqZpm7T0gOZGKTjkmVlmDsZRZiLUI1IiS2y7CzW80IbNbOhkawhD9AelJDP5lf/qtKjThTsmdAzYVANs9eCA9/pxGS95XnhakcQTPad6oyRzjFICJZ/pLMTswrolFZTbTfjXXrK0g4SiHxmCkDqm4sscqOtqwJG5rU7I/VyCVMLJvt4rukaChxnTAVvWSdWl218m/bRPB2+D3qpL/xEHeFUCBrKiU4Khk3PTakGn8bbsLEi0TyJ8qj+Xas6W4Wgw5TsRMTx9SOEn3fw6r/CnZd5nBHhTb02VMJFAlkM517HXoEWs935WcAx06Fx1rJXasJ5Wl9cMgT6JUa1EBFEmSqsyJbt/h29b2iCwFa+1MSx9OmLfdzjICRDHlYlgEIM1x+qD7SYBhBNygN3U/REC6XM4MBNydcXPGbV9xzKmxuFH2VFuzxsOfwucF5+u+oxYCyZxoLRBtUvg+3qSPubhJLTyTWwOobP79mAjewSnv7oUnihIycF02FzX3y3TNFv+L5qlqPYr4/ZhOpzE9iho4pJItgktyd2OkeYK8cC0CNUPtkA9JdvArL2HoVoywbj8t/TLqrf4aHIqX9viszOw7fhe+EaQcFFwKF5OyHVF+a5OeWp6Z+Ii5EuBgkH0nvMxg9ULPIaRT30Bo6m/i4o0eTC/63Ej8zKo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(83380400001)(38100700002)(41300700001)(4326008)(38070700005)(122000001)(82960400001)(33656002)(82950400001)(316002)(8936002)(8676002)(786003)(6506007)(7696005)(9686003)(26005)(10290500003)(64756008)(53546011)(478600001)(76116006)(66946007)(66556008)(66446008)(66476007)(8990500004)(5660300002)(52536014)(2906002)(86362001)(186003)(55016003)(110136005)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hmWWs0VEFoWjNzb3BmZmd4OWk2MGZGV0lvWXArVlJzTzJwd0Q1ZWVlWDhl?=
 =?utf-8?B?NHRBMmhvekthUG9pQXcrRGlDU2VDRFlXdERrRFZ2am0rU2o4OVdqREE2ZWJH?=
 =?utf-8?B?aTg0NGZIOFRmbVhSN0F2LzlPdHQzbmViNUg5UnJXMUFyR2VkZ3hYMzQzTjN4?=
 =?utf-8?B?dmJYSmtMVXQ3ODdSNC80dU1jc0FRSFdOYTREOFVFMVlqOXFBK0VLSGY0L3k2?=
 =?utf-8?B?ZnZzamplMkUzQXlNRlBrMkhwNCtNMk1FOEpPc3BhR2dGckpDQ0ozQWNMTS9x?=
 =?utf-8?B?T0xPK0J6b0FaOHB1V0Ixa0tlUUxOSkRsYXpjYy9uV2t1bSsyQi9RRWZtQ3Nw?=
 =?utf-8?B?MHRhRForUU5jcFd3WDkzNFlpazZuOHAvdjI1K3dOQlVMVUtjbEs5VHpCbzRp?=
 =?utf-8?B?YkZranAvMVBhMVJmdEtNMWN0ZldBWXZYeXUzcy9yWjR4dHJJOUxMSzhHaWRY?=
 =?utf-8?B?Qml2ZTgwcStNSWV4d3ROc1pUNkJxVkJVT0V3dE1yUWtYOW9YdlcvdzV5VWpz?=
 =?utf-8?B?TFFDbjZtdDZIM3lrcGxid010QVZSZnN0cWdqZDNwVWVUZ3NYRGxCMDZSTStS?=
 =?utf-8?B?SmlXU1Q1aFZ3MHV2ZUljY2d6bjRBY3RDMU9LYVFnZVVXWXNhaHNuM2E1aEYr?=
 =?utf-8?B?Rzg4UE83cExHOXB1OXRSWlUzcHYzNEw3OVY5SjlzVFZvMTVEK1dqQ1dHZXBW?=
 =?utf-8?B?RFhhZ01PdDA1Rmx6UHJLUkUyVXJuSGpmcmJtdFR6SE9vMDNJVHBybEhXSk9U?=
 =?utf-8?B?aG5xdC81cEZ1YzNOdm16SFlSOXhETWVsZUlGNHF3b3B0UldSclZLMEllUVlY?=
 =?utf-8?B?UlFtcEVOZGdwZWRmV2NxNkdGMGVIKy91NGVGVGdTUkVNVExERHhoaVVGeFdG?=
 =?utf-8?B?UU95aDd4K0V5Q09YQ0NFUWI3R0xkRlM3YzFSNDg0d1F0Z2x6aTNWT2dnT1J4?=
 =?utf-8?B?Tm1xZFlHVG9mNjBEUUp6dnVFNXRLcGpkTWhNZnVldnRrbTUzQmVzb0R1bXpN?=
 =?utf-8?B?NkNoQjhvWGlDUyt5dmJqWmZ6VjdZQ0dMcU5zUjlOWmJjUVFjc3gwWVhmbWZu?=
 =?utf-8?B?NjdxYyt5YVZZTEdOc1lFQUhDa3ZpUXRpN0dGS0JtNDNyeDB1a2J0S3EwTEdx?=
 =?utf-8?B?VVM5YXVCOXczZDg4NE1DdnJzOFRDT2pHV1hPQmlLTjV4Q0dOcHk1b2c0OVZm?=
 =?utf-8?B?UVIrcUp0ekl1SkZHZ3ZjRlBqU0p6R0UyMktZcVRCeXpZWkxUYmFNL3NtL24v?=
 =?utf-8?B?SmZjbVJPNHFad3gyTSt2VmsvQ05oTWQvelNwdUgzb2lzWk1MQVh5dWVUMXZi?=
 =?utf-8?B?cmsvWHRYYmJWWmZkdytSSjU2ZHVRR1liTzY2Y2cvVHBjZmJ1WGc5SU5rRnFW?=
 =?utf-8?B?NDg4Y2RnWWlOVmE4bERyTElRcHM1V1RFOXJ5YVNNcTN2VHhNcERJRVJVR2xJ?=
 =?utf-8?B?RlNLMHA2VzhJMXRWMjloTE9sQlJ3MGh3enVZOXRMcXlsRzVUWW1HWVE2Y21R?=
 =?utf-8?B?L2V2cFN6ZGNwZFZRNkhEZGtjVEhhRzBOYVRZQkFhaG9uT3VEd2lrNjBYWE9B?=
 =?utf-8?B?YUNheWpSczRHSmYwcE5yRjBSMzV0UFMzMmlsQkxKM1F6ZzdlRHFHdTE0RGxS?=
 =?utf-8?B?ejlHWDErMGljeXVONlRaUkxnTzFMaWQxOUp0TWFkN1Y2Z1AxLzNOZm9CYzZC?=
 =?utf-8?B?YzRDY1dSTm9MaWE5dkN6VmZFeERRWWxIVXJPZUlLRGF2Zk5ORkFoS0pGdC9i?=
 =?utf-8?B?c3RySm9icktUbDk0WWlOQk5EbUlnWkFBWW1iLzg3eGh6d25wK0hqOW0xTlBU?=
 =?utf-8?B?Y1psTUdvMThpNXprYmZpRzJhdXkvL3BWbGJ0UFNtbmVFbkZWbmNHc21XZ2w0?=
 =?utf-8?B?eWdpbnoyR09rNEpLSCsvelIzYW5SQUx0SVJ0UXJwWjhpSTBNeWdrTVFLNFlr?=
 =?utf-8?B?S0NGR2luNDFZOEdFekpSOXdvTmloSHVyUFN2UHFsV3h3MDZXTjIxcGlrV2Iz?=
 =?utf-8?B?dlJxNVlwVFJXY2lqSjlOd3AvTzRnZ1hTemRsclRoRk9kZTVXUFB0TTZDaUtL?=
 =?utf-8?B?dVZ0OWpINmRrdmVyaUxDUmJWTkMwYThTUmJUUG4vSWZnZnhUczByaXl6TGg0?=
 =?utf-8?B?VjJLWHNwQWF5ak1qam10R2FMODd2ZGxERjh4aituRThCdlQxbk9ISGNDTEZZ?=
 =?utf-8?B?Q3c9PQ==?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d89e5f1-f98f-4e2d-b0ea-08db51d0287d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 03:31:07.7166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXTj+LuIL9haiAEVnQqUlZeVjq3TkLxL4NOpuzuNvGIhefqbfkF6/WTXtQgW9Iod0Lnp0ZOrfCyjboVwuTQceKNG4KEjmArWQJlM5+Q1/Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2012
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/9SGM04vbfYFL3MQN_t7DZbmLS30>
Subject: Re: [Bpf] [PATCH bpf-next] Shift operations are defined to use a mask
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

Yonghong Song <yhs@meta.com> wrote: 
> On 5/10/23 8:45 AM, Dave Thaler wrote:
> > Yonghong Song <yhs@meta.com> wrote:
> >> On 5/9/23 11:08 AM, Dave Thaler wrote:
> >>> From: Dave Thaler <dthaler@microsoft.com>
> >>>
> >>> Update the documentation regarding shift operations to explain the
> >>> use of a mask, since otherwise shifting by a value out of range
> >>> (like
> >>> negative) is undefined.
> >>>
> >>> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> >>
> >> LGTM with a few nit below.
> >>
> >> Acked-by: Yonghong Song <yhs@fb.com>
> > [...]
> >>> -BPF_ARSH  0xc0   sign extending shift right
> >>> +BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
> >>
> >> 		    dst s>>= (src & mask)
> >> ?
> >
> > I had thought about that, but based on Jose's LSF/MM/BPF presentation
> > yesterday there are multiple such syntaxes.
> >
> > ">>=" vs "s>>=" is only one of several.  There's ">>" vs ">>>",
> > there's assembly-like, etc.   So I thought that it would take
> > more text to define "s>>" as meaning signing extending right shift,
> > than just saying sign extending ">>=" here.  And I didn't want to just
> > assume the reader knows what "s>>" means without defining it since
> > neither the C standard nor gcc use "s>>".
> 
> gcc will implement clang asm syntax as well. So for the consistency of verifier
> log, bpftool xlated dump, and llvm-objdump result.
> I think using "s>>=" syntax is the best.

Just posting to the list what we discussed in person today.
I will do this in a subsequent submission since that comment also affects
the comparison operators, so treating it as separate from this patch.

> The following table is the alu opcode in kernel/bpf/disasm.c (used by both
> kernel verifier and bpftool xlated dump):
> 
> const char *const bpf_alu_string[16] = {
>          [BPF_ADD >> 4]  = "+=",
>          [BPF_SUB >> 4]  = "-=",
>          [BPF_MUL >> 4]  = "*=",
>          [BPF_DIV >> 4]  = "/=",
>          [BPF_OR  >> 4]  = "|=",
>          [BPF_AND >> 4]  = "&=",
>          [BPF_LSH >> 4]  = "<<=",
>          [BPF_RSH >> 4]  = ">>=",
>          [BPF_NEG >> 4]  = "neg",
>          [BPF_MOD >> 4]  = "%=",
>          [BPF_XOR >> 4]  = "^=",
>          [BPF_MOV >> 4]  = "=",
>          [BPF_ARSH >> 4] = "s>>=",
>          [BPF_END >> 4]  = "endian",
> };
> 
> Also, in Documentation/bpf/instruction-set.rst:
> 
> ========  =====
> ==========================================================
> code      value  description
> ========  =====
> ==========================================================
> BPF_ADD   0x00   dst += src
> BPF_SUB   0x10   dst -= src
> BPF_MUL   0x20   dst \*= src
> BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
> BPF_OR    0x40   dst \|= src
> BPF_AND   0x50   dst &= src
> BPF_LSH   0x60   dst <<= src
> BPF_RSH   0x70   dst >>= src
> BPF_NEG   0x80   dst = ~src
> BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
> BPF_XOR   0xa0   dst ^= src
> BPF_MOV   0xb0   dst = src
> BPF_ARSH  0xc0   sign extending shift right
> BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
> ========  =====
> ==========================================================
> 
> In the above, the BPF_NEG is specified as 'dst = ~src`, which is not correct, it
> should be 'dst = -dst'.
> 
> See kernel/bpf/core.c:
>          ALU_NEG:
>                  DST = (u32) -DST;
>                  CONT;
>          ALU64_NEG:
>                  DST = -DST;
>                  CONT;
> 
> Could you help fix it?

Yes I can put it into the same patch as the other change
discussed above.

Would like to see the current one merged so I can base
the next one on top of this one.

Thanks,
Dave
-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

