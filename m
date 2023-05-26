Return-Path: <bpf+bounces-1330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C803E712BCC
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692191C20EE8
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66C28C36;
	Fri, 26 May 2023 17:31:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD0271F6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 17:31:06 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDB1194
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:31:05 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B69D5C151B3F
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685122263; bh=uRxKuMWXT8lSOLGJ0B/HjKFZv2/xnuc/18L8Tq9eVNM=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CCDtfu20CR7Xnh7kCU/4e2bkBlaQchujaECv7Ij/ARiFaePAGQN2h0LpOmDJgoi2O
	 CytagFWqGV0g7bVkQK1EeT5RNMnafw/0yQrahohPhTnMVGb24NzbtaN3BXh6JQOuK0
	 NeV79kmUdKaegsLuvL9WKBYibd3wJdSfLgGvV6VE=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 85179C14CE4A;
 Fri, 26 May 2023 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1685122263; bh=uRxKuMWXT8lSOLGJ0B/HjKFZv2/xnuc/18L8Tq9eVNM=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=t43x9lEzq/IXr5bEF6nsec5ryWNtgpiZxVKLsK7bJjWPiFTh60P+tnMBTXO9Bm7O9
 zEbdMhX0LOaxZ5zq+YpjkCfSzYz9I0b6kqzSi4BrqUkHRKNjQXyjcuorPzEctYjXsA
 eh5Yu6i+z3zqVhseU14J3IhxJLr6sgV+a6Lv5OjE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 67F00C151071
 for <bpf@ietfa.amsl.com>; Fri, 26 May 2023 10:30:32 -0700 (PDT)
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
 with ESMTP id m5MowQkkGGKf for <bpf@ietfa.amsl.com>;
 Fri, 26 May 2023 10:30:30 -0700 (PDT)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com
 (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E3E41C14CF1C
 for <bpf@ietf.org>; Fri, 26 May 2023 10:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx/3slaPebXztPZ4aQNzxJH6ljNOTYb4vV+I7JwtxZTrzOB3t6sD6eyqEeJSSkpE9z4ATdR9+/Np/fzoG1LqkRpPNmyRNxjdGa/vppyu/kI+wXHwLVS34CwDulWxlePF2v3p4BCj6dfySS2rFbyGVphYPKgom5aueL6e9sasbU4/AAWHNelED1mGBm0Vkxt88XgWCd8N2ZPgGUteYKgtMaOaARNWiyHlaruLxUPBSUaf/rVkywGZqwHNy7G6Yn0Gct++Bjh115IHmI+Fzht0rKl2fghp5x13670nZ44Uo0ALYm90Z52TZVCX1v95pKH5sgTS2ftxNSJWksRS+Kew/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvPclQpyoZYXW9VcV1m+cC17DEK+4mwi8j/MvDnaks4=;
 b=Xad0sAU6Tqyhn4JXb6PBJsNYV4s1BVGGqNQgiivhUaV7B6uHuoxLbwlxXFuTsJkCfPtxIq7QxGJneQeoHJqkiIEnJXe6ka0S4WH60pDP6FOVVrNxbiRyT+spkAIO+2LllxVnKSYqFVjE2fTFLiY4qZ9iPcxO66zmqpAYpBGw5fjjv2DvCOaP0XfWydwe9rvRLUpBq4HUrEgpQixlXLKwkVGdmdYpUHPOMVFdWABluVc7JwDT1JZbkuVpvOj6wgp37tC+jnVsHfqukxb68phSj+merbzO0BPt2lrO+Z4yfCvTddVq8iwWSasoqlgKkahGF8dzU1rx+8mtR/g0gXyWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvPclQpyoZYXW9VcV1m+cC17DEK+4mwi8j/MvDnaks4=;
 b=FmJj7KVfnsL4ylroF4Vm6PmRDVIjvzihjYY1Hgzgqy6vDaVrzPe4ahHs0Fz4lSLH++tDnt00DdQ6PkwY0wuLafxIvNUr4R/biDMaHXeu7hcJig4n0C8mWHPvyCX6C2OEopchAoBaKhydQFGFCdPSlZdPTgpdDiOgO2uAQ91RWiE=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BYAPR21MB1334.namprd21.prod.outlook.com (2603:10b6:a03:115::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.12; Fri, 26 May
 2023 17:30:12 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%4]) with mapi id 15.20.6433.013; Fri, 26 May 2023
 17:30:11 +0000
To: David Vernet <void@manifault.com>
CC: "Jose E. Marchesi" <jemarch@gnu.org>, Christoph Hellwig
 <hch@infradead.org>, Michael Richardson <mcr+ietf@sandelman.ca>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>, "Suresh Krishnan (sureshk)"
 <sureshk@cisco.com>, Lorenz Bauer <oss@lmb.io>
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index: AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAwOVAAAFPnKAAEnmqgAABUBbrgA+cTCgAAHU2oAAABSogAAAxJqAAABQzoA=
Date: Fri, 26 May 2023 17:30:11 +0000
Message-ID: <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526171929.GB1209625@maniforge>
In-Reply-To: <20230526171929.GB1209625@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48d35aeb-32a7-4693-9cfb-28ddefc37aed;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-26T17:28:31Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BYAPR21MB1334:EE_
x-ms-office365-filtering-correlation-id: 631a664a-3f97-4f8e-a0c9-08db5e0edc19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jo905AOL93974Vv72llN4A3jaBi2n6+kx2CuFTSkMUY7N6qnVf4vcTkWDmXe4OIeQ90upx1dkbFp5p6ohQZvK3mAzczvfuTqCnndZgq64XWUVoKpw9fqp7Yb4qGo2Tku+nPPUcYl4GnnTflXLHCpnaheTVJWmik3t6tOZlGxVxl/rr8bFj7GKcYnZcLlXUVKbE6zaa2oQOBkb8hFJwP8c5LfRPSL+PtVXBuplBhTA1f7qXrCt0a2p7Xn7t2howCMTNsGqEAjvBJqot7eWMr80w2XgIeBXg93uSJCKXWuAjBaW5jlZ5gr5jI95QK87okNaVYrzdlIYR0uTas+Q5vTSxHaph2Cc5Bp/+C7t6tH+dpxlUl59kQNo12iB8UrV95aYI0hxlWW/oBlV+nXz1t1al95fqzcRHpbUfoKliZghdMaBjwRxtq40eZdg9WGHk+n6qtUxuUHQ6KOLBRBvmyC9EKZuj3fnd42p3xJYoyyWcffeYABkj/mT2BQXPkTERx5GRVOGdMdS2QEYzKFp1UmyEvwyb/ncjVO25c3bz2dPl+BAS4EqHZrDYQMB4Hr+bO8CEacAOnvmMg3RMI3e2Ac3ZvEp8hppf9evsS6OpFgg+pVh/BErM14uw4Thc39Se0ZRe2newJV7Ga14JhaqwK/8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(54906003)(2906002)(86362001)(33656002)(186003)(6506007)(10290500003)(9686003)(8990500004)(7416002)(76116006)(64756008)(66446008)(66556008)(66476007)(38070700005)(52536014)(5660300002)(66946007)(6916009)(4326008)(8676002)(8936002)(66899021)(38100700002)(82950400001)(82960400001)(122000001)(55016003)(26005)(786003)(316002)(71200400001)(41300700001)(478600001)(966005)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I1A/YVTLKM7gfs2i3RlZD7xKlvcGeeoVhbScctocG38KROMilYJ5dUMrWirp?=
 =?us-ascii?Q?Rlao54/M5e0kXrIPue+3M3t0tm84hUWzTuluvOxkqGkfe4ndUX8JS/ThrseX?=
 =?us-ascii?Q?S+gK0LYWPp+YT76Z5rXRH4lBStgPOeq7WxaoZRLXtSwPN6ZisM3mpfDXzyCL?=
 =?us-ascii?Q?nNTBtWkhqceg3SQNPQJAOZ82Mmlnx7yQNqLlDsChem6dGbibfIn2S/pv+w7Z?=
 =?us-ascii?Q?6jTNB5BDpyYrJ2iXnt+gCr/i5zODluBxbniuIHe4y+38lLPYkAVMxFeXoh6K?=
 =?us-ascii?Q?D/Otow7qeoeg8RYhocNnBQ2vc4OK1eDH5W/2c4sx3Ek8J0/tIEiCw4QzGMWu?=
 =?us-ascii?Q?sXXLBFYVB96qTWUagvkI30Cd5cKiC62fiChPRyRAVNubigJEM59VMFz+Pnj0?=
 =?us-ascii?Q?kVd3rohQN7/TBvWfuJaEv9l3TvPayNUJ4cbumsjJlFYz4BKbxlBCVD+PSKpb?=
 =?us-ascii?Q?9RbbGxg/Vo3XhU+SbHiN4wSEhOWBKh0PQ7rpvZ3Y9nY/FPe1vUVSvBWRZzbH?=
 =?us-ascii?Q?GqJkJ7Yh7M8Tl+UvfhuyS8q1NsCKv7HuR6kWVD8DlBmJ20bZ9SW0lTShB81Z?=
 =?us-ascii?Q?OxSHAgB+EoM9dc3ZAHljXf2iWPRiPOUflx+rweb/z1JhXAsuY/C6IFjemUYt?=
 =?us-ascii?Q?qWjrKyzetg/G4A2zRBABBEL7IlsiThOZzv8IaWhGJvzCMPoLhG2lyYSnbG+A?=
 =?us-ascii?Q?g1VhCrzc+OiAh9uViR1HagIytlg8xshMCR/vSIHf1IYYqNX3uzmhboyvXRtj?=
 =?us-ascii?Q?sX61Sfm6TXcZB3YYoUygiROeukDBOfs/tlieY2j6sQ2HJedefG3cEAp+k5cr?=
 =?us-ascii?Q?6t1h5UsuTgBr23uRN71O/ttwPRHTa5OXJFTu23qBVBXdK/aGmaGU+6ofcAf8?=
 =?us-ascii?Q?vj7CHr7vQpVafCguzzjlcQynmG4OAo3xJfAFZ5l6YIX9PYtBgfj7Ko0lIQA3?=
 =?us-ascii?Q?XWUBKROLE889h3bS0+IO6ySs9sfGgcTuvdLO3Co8CoANcGIy5l6c+GsT9qGC?=
 =?us-ascii?Q?b+MqHy3yP/0KkFNliDr26saQTXa4abe4zxmOhJntkAoDl/dU3xAcBVeJ3JH4?=
 =?us-ascii?Q?mxg4eRot6f9p9LQNr1JtbEcxSd3lQOJMA/P6i0z3iC03mnEXpSq7glfuTQTN?=
 =?us-ascii?Q?gvAOy1QT/MYxMxR1ITAYmXALUZESu4A8HSICANPIQq/2JCUsjKCmvY/8zQ7u?=
 =?us-ascii?Q?A0KWWMleK69nDPkxfbY0L832geE2WvjvAnWmTUAuPiwLqkzuKN79f6g6LtBR?=
 =?us-ascii?Q?JV45py7Wnlrx8kNz4JQOZ+G+fcwFvP64vjwgFBaqf4pM8a+5cNmQqoEYhCsM?=
 =?us-ascii?Q?v4ig3v1mI+plMcwpRKMLTuNLwMYw7KqZQvqI0b0ooxkp+15u7QBR99J5XUwQ?=
 =?us-ascii?Q?gZ6zKYBWUldpqPqTfT6JwPmarY9uWfypBFwCSpU3QNM0jyEllyt7s38kc5QC?=
 =?us-ascii?Q?yrtqzP4AwrSQzLMCFzxKoll4aI7d4TkYZbvjXEtSz8BdH4u7a8bHBBl6J7Mk?=
 =?us-ascii?Q?7KpfeawMhhVFaeCxQPDuG6GVREddCTCyKK0i5P8o8u0g7dmYWn1qVqPVeTGl?=
 =?us-ascii?Q?/hQneKrDTc+eLf2LRJlcq3CzlA7NNDDV1zsHoJDV59xb24QmmCJxY4MencLn?=
 =?us-ascii?Q?2Q=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631a664a-3f97-4f8e-a0c9-08db5e0edc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 17:30:11.7952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBTj3hIFtfikOzcEJMvEl49qifNgi5KbTzwuClQFI+7hLQD1cDFPRqyY+/cZau7vmzKTsM2wIqzh4vYE1qBMAokh7UayaAapUI/VbN4BYKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1334
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/YobhiD9DnlqXFNEovAJATj2UCqc>
X-Mailman-Approved-At: Fri, 26 May 2023 10:31:02 -0700
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

David Vernet <void@manifault.com> writes: 
> Thanks for clarifying. Erik, Suresh and I met yesterday to try and find a middle
> ground that addresses everyone's concerns, and we came up with [0].
> 
> [0]:
> 
https://github.com/ekline/bpf/blob/ekline-patch-1/charter-ietf-bpf.txt#L31 
> 
> Does that sound reasonable to you?

Yes, other than some punctuation nits (https://github.com/ekline/bpf/pull/7).

Dave

> I must admit that I feel quite strongly that a Proposed Standard is not the right
> move for now. Many of the existing ABI conventions that exist today are simply
> artifacts of somewhat arbitrary choices that were made early-on in libbpf. I say
> "arbitrary" here not to imply that they weren't well thought out, but rather just
> to say that like many other decisions in software projects, they were made
> somewhat organically and without the benefit of hindsight and a larger corpus
> of participants.
> 
> > As an implementer, I would want to make sure that ebpf-for-windows,
> > PREVAIL, and uBPF all do the same thing, ideally matching Linux for
> > everything the former projects support, to allow using consistent tooling.
> 
> I completely understand the motivation. Hopefully an Information document
> will address those concerns? Let me know what you think.
> 
> - David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

