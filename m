Return-Path: <bpf+bounces-1324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B0712B55
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C328195C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5028C0E;
	Fri, 26 May 2023 17:02:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B96271F6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 17:02:24 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD6BC
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:02:22 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B2304C151B3F
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685120542; bh=I7vPlv0IXOe+D1F64Y4iJfPqduwD+b4r2xgJ5ExVezY=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYX6F/fVTpWSUk3R5CC2vHJCLpdMQf5tg+6jwqVeSNuJhuxXMz21AeWPEnli5FbQw
	 5rtsi3XGysvu4uWcz3v36WjFPj4uiKca6xxVKHDe+BgZ+xaSZxQmVULa9+Ix5DePdl
	 +AS+yPF+cXojwZI+4jlGwDTeXTRJtvwcNY3C+qcA=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 938B0C151545;
 Fri, 26 May 2023 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1685120542; bh=I7vPlv0IXOe+D1F64Y4iJfPqduwD+b4r2xgJ5ExVezY=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=sHFWfbT+GebsPB2h7wXktHBajzhVpAcnzXN8FDDiHdGrXuruunr0zpCJtNTJV5R6R
 xYYsxUDArVX7AT96Hz5Yi4Hznj7ZmJc05+BHzp0LHXenpsTAxBKRkvNuz6KuO+fl4d
 y1NS3/0AFzfdiFlrvEvhIPA6lmdyWtU/bS24MIHo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 42347C151545
 for <bpf@ietfa.amsl.com>; Fri, 26 May 2023 10:02:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.102
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M0dGQrvr1aRA for <bpf@ietfa.amsl.com>;
 Fri, 26 May 2023 10:02:20 -0700 (PDT)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com
 (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E07BBC151540
 for <bpf@ietf.org>; Fri, 26 May 2023 10:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8J3xJhn8uiJQXRqf5GrYtMG6IasVqdH4Myzwzi9szFPSHSFs/2KlBlD4FdJr+EfYKfX1L5R/W4NzR62/BjuXtNPWmjI8827IlCVxG/sxajTyU9KPsWoSkfLkn7tqU2ZHG9Sdh75p8CckIQnSAzqnolLktTrKMj2mITOwPKIVZ5Hsm+vZuSRj+vOutWOWlwDvygniTDkrR106InLZ6+C9nsf9Nd9rnyEgUYS1LTblb0kB1U7TpSeYHN26dv9shezdq8QUWpvdw9tIK6UF9uKNlRXMePn5aqJFQ0sh5ZGwBVqxSL+bjDAMfw8gBAaoyHg8y0Ag7l/TiUVyzIdcN6PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R3fO9QHrqKzH21kPh9GsDjQgDbkM6Gi7/YBhOfWs28=;
 b=SJvAHRaMJyGXo+GhWxMjszFPIYZU2EOdv/x/tfBZILbLvIC4oRFjWfD4qc+whAZBYfQMgegq8V1QZcQVr0wLIlJZbscFaMZBJMse+eOjBxOCsnUjvqxNYnGzOlgC7W1M3RvKVAQDRMvRrHNDTGLzmCvORCm7ef7Selcb5ZpMxo0+s8G47NqffKSlQrNisukMybmNyrGC8riEbLLWqJpFIsBymhPmE/mTsxJWCGBhnxhQHfC3+YOqYvidiPybF3ZI8lSYS06T/nMIs0K6WLkwoEWfdfh02lUSM63LAykIzR/Rr541rp70ToagItzKv6etU1n9zP6vGNrYMDSivoFZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R3fO9QHrqKzH21kPh9GsDjQgDbkM6Gi7/YBhOfWs28=;
 b=EG+CTe8OcXfaqhcOq5VK9e+/Cqk8cCthLdtY7YW1ncXR3kiMf/7tbXIeNyiv795G6klvV4ma/KMDpFhQk8kbiQ6iqIj3D5hp+CyinDlnjOf+klKIYAhj9Pymjyx3OPJy/psHtOl7WFapTwnF5OcO73g4UNsg8OojkFPk6Oq6LYo=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MW4PR21MB2042.namprd21.prod.outlook.com (2603:10b6:303:11d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.7; Fri, 26 May
 2023 17:01:57 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%4]) with mapi id 15.20.6433.013; Fri, 26 May 2023
 17:01:57 +0000
To: David Vernet <void@manifault.com>
CC: "Jose E. Marchesi" <jemarch@gnu.org>, Christoph Hellwig
 <hch@infradead.org>, Michael Richardson <mcr+ietf@sandelman.ca>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>, "Suresh Krishnan (sureshk)"
 <sureshk@cisco.com>
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index: AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAwOVAAAFPnKAAEnmqgAABUBbrgA+cTCgAAHU2oAAABSogA==
Date: Fri, 26 May 2023 17:01:57 +0000
Message-ID: <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
In-Reply-To: <20230526165511.GA1209625@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e43ef4b7-ab8a-484a-ad3e-6ea01035c8c8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-26T16:57:29Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MW4PR21MB2042:EE_
x-ms-office365-filtering-correlation-id: 1a8d6bf9-5ac4-42cd-b54a-08db5e0aea52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgoW5w8dsuUTJ0jKz6sgO8KEZbJ1gFqfq3sbW1JUz6Pv9bDFMRCBYy6msqO7a2krF/Q0CxhW/sXjqlSXITjsPLcor+l7G3F106Ebtzh11RPwsWZIhrzCI447p2/O1wUL3U5N7Xm3vR5jCJS2L01/nh7T4Ewtplb5Dk7OGhFoNbB6Ue757qTg+orurSRE7nbn6oRyCvm/jCt26TFS8JVnoviuEoNfARk8iyKM5W4VPLDXRtqqLBX57+/ZE7cpRI6ZXUdU/oACTmv0E9gi/tprgEKQ9vzCVAje0K+2VzFLt1R34Pnb3/Ns3JjfqyqXTSf++32r2Soq93SAN8VUktPttUZVJckBn1T1doSP2trd6BhdJt4uvBMEiTpfM996KTHVo8G3kBBdDRxmA3mKeaUFBEHyLJ3iKFoJpB5w1yM8BvA1CR//d6/IdIA6cZ9zruPK9xDfKScnIbuBEKRT2PzTKKL7GfB9s0TQWNsxwKS42NVB4A1bVhIgAy6lr+nZFLgVaqIy8G9X0Vtn836J5pVufhXa0sHEAe4QgowKIQgcT7JgB4QqKe7JEENCRdHdxfAgTBBP47SswH476MuBa9QEBrC+O5ykJQYqGlBcAIuWsHcqkPsdi+0pyiyaEEakJV5YhXSZSEQlIQTntc3AqigeAU0Zix1JagufvSSyBw+MjNc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(52536014)(186003)(6506007)(86362001)(9686003)(38100700002)(26005)(122000001)(82960400001)(82950400001)(38070700005)(41300700001)(6916009)(66946007)(71200400001)(33656002)(55016003)(66556008)(10290500003)(64756008)(66446008)(66476007)(786003)(4326008)(7696005)(316002)(76116006)(478600001)(54906003)(2906002)(8990500004)(66899021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rf6vF9ZpPyLZYtG1fWjuhPbJEuHniN3yrcDz/atZnbpXUFdoJ01iet3XQCR3?=
 =?us-ascii?Q?Wbwn6mMUEcZSu56T/ieO9VI88ksk1M0G4AVETfOu469EGXHLy0EUEHNyFg7y?=
 =?us-ascii?Q?CEtwyBhtfyeMDmGab3YNZCkd3ZGwTXNKqNjD5zCzRIRkWV3POslKRxlOj16p?=
 =?us-ascii?Q?v0oqYftQhAYHUjLcMbAtEs27idu8Y610H9JpawIWr0M3epBpMItlGcMFhYCV?=
 =?us-ascii?Q?mRdRBx/33vRnAvW5JBVZUYTurMUnhiNm6w4sSpbYsOjYsrz9CcG6pw5mJv7d?=
 =?us-ascii?Q?kNkVEkBsmEyY69m7ibvHPrXU4OVjxEz0he8WovSu4Af30YKiFikLXleIwTAe?=
 =?us-ascii?Q?fHk494z8MMYFEZBuPyD4hphXh5ptyEl5yFc4lfmZ1kETwFbz8q+JKWgvbwnl?=
 =?us-ascii?Q?VlUnVaGbh78/fiq1A3RazvnDED5WvHsswJJ+qnIJkkv0WYrpznszUcyZ5V37?=
 =?us-ascii?Q?SLRztWOXZdTaDBFi6az4HHBJl2ILLnC/7YDnG/BP4nVo1RnqcqsC1zNHhAEN?=
 =?us-ascii?Q?AaQApbBjG2dOZ707JvGea73fngN/QUy73TFKplEeN2LNM1KcEAm8YZ667n5J?=
 =?us-ascii?Q?/x84WERRQNCdPKCoXkPEkEgad9pVM7PgNoL/u/nNRlUGs9elHOOyHBg/hadF?=
 =?us-ascii?Q?d+XaQklISbqss45QOhZU7Wkz8PDtKkee0XaY9Dj7H41Yyu38pexhc2ts6k2r?=
 =?us-ascii?Q?AJjgiPzAT1IZXyq1HArIYU/DG2OrTt0y5kvbJ7UiiFeaF6EK2KTJQSyERdKF?=
 =?us-ascii?Q?dZ3RvgbefYc8WK0NqL9oU3GjAgNZDkMPnf0xLFZd4ZdGp79+/2I8Smy+2H7K?=
 =?us-ascii?Q?M/zELsszZ6eHKpjwka6QW4k67xoD0ykoXg5RCpbw3B+guFyMXO9LtkG4FMnX?=
 =?us-ascii?Q?+czDYNP+n9HDisZL6nGk2VyRAuQIxWJtJxc/GVqSHsckgRLRn5XTxCySCI2k?=
 =?us-ascii?Q?a/IX7dpfucOUEw0+nKRmvj6xrxcVHuWSzVdLp0rlmSUrzfKiq6NzBklXOv/4?=
 =?us-ascii?Q?DqK78FMbcQRNKjDR3jT2YUlrrUdnpWl/hk6gt9MO16Tidck356sS8DM9XVmf?=
 =?us-ascii?Q?y6ButbNYblG06E3siHwaqn4pih83lRsm/JKdXWkkFGmu9FVXV1Sm9oXVEwVW?=
 =?us-ascii?Q?cxW+7XMqmzp32k0MKEzvLUsOsFTdNJcRySSimKRl6Z+CWbW452lfDa6Wdgyk?=
 =?us-ascii?Q?3/hHC7PY08qe900ORops34if+llOPgb+en5FYff1E1jHGsN32PEng/7dqTpg?=
 =?us-ascii?Q?RC0SKkh9k2GyLyhN6fltsxrplR4fciXK35lJbT/ZGX6VB0gBkpV0sa6y7iSI?=
 =?us-ascii?Q?Yp9yDVIhqMXJu8efQ/uKC1Cr77hRJkePYtLiriHx3q+YfRPoLFkCFnjEBuYd?=
 =?us-ascii?Q?4xgwXCtIKriOtxbvsgoFsi2O7JFeNyUSlF4+WOWGxg077S+6x9WF6a+AHpUX?=
 =?us-ascii?Q?QPh9CIpxc+8t30xPixYw339M35l/YGvWrM+ZQwCOPTV7bmlGG599Sw6YWL7F?=
 =?us-ascii?Q?ZMv0SJHNNBs05wsS9YIpN3r2q14u4aOVgxkqU5h9SJ4gz+lz/wQzLiI6oLyE?=
 =?us-ascii?Q?nwAK8ib74O/mtg8q5Bm/Ae7wTemHE6ThHJ4tI0Ei1pIRGIUjqcHAvveEOFZK?=
 =?us-ascii?Q?Yw=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8d6bf9-5ac4-42cd-b54a-08db5e0aea52
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 17:01:57.6851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n4jXFBV7WwUasEQoNP8D1hmebjdLeK9k0UqWlHuvxqWvux4WOH9pn2Ae1GvJ3TIwIhI3UIFR0jWwCuYVII/DAwCXRhgIk5uI0MI3pH3Peg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2042
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/vgFPINkxwM4jamZdOcWFcUcywHo>
Subject: Re: [Bpf] IETF BPF working group draft charter
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

David Vernet writes:
[...]
> I'd like to highlight this line in particular:
> 
> > This means any version of this specification published at the above
> > link can be regarded as stable in the technical sense of the word (but
> > not necessarily in the official RISC-V International specification
> > state meaning), with the official specification state being an
> > indicator of the completeness, clarity and general editorial quality
> > of the specification.
> 
> To my reading, this sounds a lot more like a (strongly advised) informational
> document, than a formal standard.
> 
> > The eBPF Foundation could publish the equivalent of the
> > riscv-calling.pdf document above, but we (the IETF and BPF
> > communities) decided the IETF was the best place to publish such
> > documents.  As such, I envision an IETF RFC for the BPF calling convention
> that is very similar to the RISC-V standard one above.
> >
> > Given the precedent, and the need in BPF, I don't see a problem.
> 
> Just to make sure we're all on the same page here: Are you proposing that we
> publish a formal standard for psABI specifications, or are you proposing we
> publish an informationl document?

In an email last week to the list I mentioned Informational as a possibility.
I don't have a strong preference, but I have a weak preference for Proposed
Standard status.

As an implementer, I would want to make sure that ebpf-for-windows,
PREVAIL, and uBPF all do the same thing, ideally matching Linux for everything
the former projects support, to allow using consistent tooling.

Dave
 

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

